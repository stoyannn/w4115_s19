#include <execinfo.h>
#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "jijoruntime.h"


/*
 * Support functions
 */

char* _type_str(unsigned char type)
{
  switch(type) {
    case TYP_VOID:
      return "void";
    case TYP_NULL:
      return "null";
    case TYP_BOOLEAN:
      return "boolean";
    case TYP_NUMBER:
      return "number";
    case TYP_STRING:
      return "string";
    case TYP_OBJECT:
      return "object";
    case TYP_ARRAY:
      return "array";
    default:
      return "unknown";
    return "";
  }
}

void _fatal(int code, const char *format, ...)
{
  fprintf(stderr, "ERROR %d: ", code);
  va_list argptr;
  va_start(argptr, format);
  vfprintf(stderr, format, argptr);
  va_end(argptr);
  fprintf(stderr, "\n");

  void *callstack[128];
  int frames = backtrace(callstack, 128);
  char **strs = backtrace_symbols(callstack, frames);
  for (int i = 0; i < frames; ++i) {
    fprintf(stderr, "%s\n", strs[i]);
  }

  free(strs);
  exit(code);
}

void _check_alloc(void *ptr)
{
  if (ptr == NULL) {
    _fatal(ERR_MEM, "memory allocation error");
  }
}

void _binop_typecheck(char *op, struct _value op1, unsigned char typ1,
	struct _value op2, unsigned char typ2)
{
  if (op1.type != typ1 || op2.type != typ2) {
    _fatal(ERR_TYPE, "wrong operand types: %s %s %s",
       _type_str(op1.type), op, _type_str(op2.type));
  }
}

void _unop_typecheck(char *preop, struct _value op1, unsigned char typ1, char *postop)
{
  if (op1.type != typ1) {
    _fatal(ERR_TYPE, "wrong operand type: %s %s %s",
       preop, _type_str(op1.type), postop);
  }
}


/*
 * Arithmetic operators: +, -, *, /, unary -
 */

struct _value _binop_plus(struct _value op1, struct _value op2)
{
  _binop_typecheck("+", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1.type, op1.value + op2.value};
}

struct _value _binop_minus(struct _value op1, struct _value op2)
{
  _binop_typecheck("-", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1.type, op1.value - op2.value};
}

struct _value _binop_mult(struct _value op1, struct _value op2)
{
  _binop_typecheck("*", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1.type, op1.value * op2.value};
}

struct _value _binop_div(struct _value op1, struct _value op2)
{
  _binop_typecheck("/", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1.type, op1.value / op2.value};
}

struct _value _unop_uminus(struct _value op1)
{
  _unop_typecheck("-", op1, TYP_NUMBER, "");
  return (struct _value) {op1.type, -1.0 * op1.value};
}


/*
 * Comparison operators: ==, !=, <, <=, >, >=
 */

struct _value _binop_equal(struct _value op1, struct _value op2)
{
  if (op1.type != op2.type) {
    return (struct _value) {TYP_BOOLEAN, FALSE};
  }
  if (op1.type == TYP_VOID || op1.type == TYP_NULL) {
    return (struct _value) {TYP_BOOLEAN, TRUE};
  }
  if (op1.type == TYP_BOOLEAN) {
    return (struct _value) {TYP_BOOLEAN,
	    (op1.value != FALSE) == (op2.value != FALSE) ? TRUE : FALSE};
  }
  return (struct _value) {TYP_BOOLEAN, op1.value == op2.value ? TRUE : FALSE};
}

struct _value _binop_nequal(struct _value op1, struct _value op2)
{
  struct _value ret = _binop_equal(op1, op2);
  ret.value = ret.value != FALSE ? FALSE : TRUE;
  return ret;
}

struct _value _binop_less(struct _value op1, struct _value op2)
{
  _binop_typecheck("<", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1.value < op2.value ? TRUE : FALSE};
}

struct _value _binop_lequal(struct _value op1, struct _value op2)
{
  _binop_typecheck("<=", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1.value <= op2.value ? TRUE : FALSE};
}

struct _value _binop_grtr(struct _value op1, struct _value op2)
{
  _binop_typecheck(">", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1.value > op2.value ? TRUE : FALSE};
}

struct _value _binop_grequal(struct _value op1, struct _value op2)
{
  _binop_typecheck(">=", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1.value >= op2.value ? TRUE : FALSE};
}


/*
 * Logical operators: &&, ||, !, is
 */

struct _value _binop_and(struct _value op1, struct _value op2)
{
  _binop_typecheck("&&", op1, TYP_BOOLEAN, op2, TYP_BOOLEAN);
  return (struct _value) {TYP_BOOLEAN,
	  (op1.value != FALSE) && (op2.value != FALSE) ? TRUE : FALSE};
}

struct _value _binop_or(struct _value op1, struct _value op2)
{
  _binop_typecheck("||", op1, TYP_BOOLEAN, op2, TYP_BOOLEAN);
  return (struct _value) {TYP_BOOLEAN,
	  (op1.value != FALSE) || (op2.value != FALSE) ? TRUE : FALSE};
}

struct _value _unop_not(struct _value op1)
{
  _unop_typecheck("!", op1, TYP_BOOLEAN, "");
  return (struct _value) {TYP_BOOLEAN, op1.value != FALSE ? FALSE : TRUE};
}

struct _value _binop_is(struct _value op1, struct _value op2)
{
  return (struct _value) {TYP_BOOLEAN, op1.type == op2.type ? TRUE : FALSE};
}


/*
 * Object field and array element access
 */

struct _value _func_new_composite(unsigned char type)
{
  if (type != TYP_OBJECT && type != TYP_ARRAY) {
    _fatal(ERR_TYPE, "wrong type for composite: %s", _type_str(type));
  }

  struct _composite *comp_ptr = malloc(sizeof(struct _composite));
  _check_alloc(comp_ptr);
  memset(comp_ptr, 0, sizeof(struct _composite));

  struct _value ret;
  ret.type = type;
  memcpy(&(ret.value), &comp_ptr, sizeof(struct _composite *));

  return ret;
}

struct _element *_func_find_id(struct _composite *comp_ptr, int id)
{
  for (int i = 0; i < comp_ptr->length; ++i) {
    struct _element *elem_ptr = comp_ptr->elements + i;
    if (elem_ptr->id == id) {
      return elem_ptr;
    }
  }
  return NULL;
}

struct _value _func_get_element(struct _value comp, int id)
{
  if (comp.type != TYP_OBJECT && comp.type != TYP_ARRAY) {
    _fatal(ERR_TYPE, "wrong type for composite: %s", _type_str(comp.type));
  }

  struct _composite *comp_ptr = *((struct _composite **) &(comp.value));
  struct _element *elem_ptr = _func_find_id(comp_ptr, id);
  if (elem_ptr != NULL) {
    return elem_ptr->value;
  }

  struct _value ret;
  memset(&ret, 0, sizeof(ret));
  ret.type = TYP_NULL;
  return ret;
}

int _func_set_element(struct _value comp, int id, struct _value val)
{
  if (comp.type != TYP_OBJECT && comp.type != TYP_ARRAY) {
    _fatal(ERR_TYPE, "wrong type for composite: %s", _type_str(comp.type));
  }

  struct _composite *comp_ptr = *((struct _composite **) &(comp.value));
  struct _element *elem_ptr = _func_find_id(comp_ptr, id);
  if (elem_ptr != NULL) {
    elem_ptr->value = val;
    return 0;
  }

  if (!(comp_ptr->length % COMPOSITE_INCREMENT)) {
    comp_ptr->elements = realloc(comp_ptr->elements,
      sizeof(struct _element) * (comp_ptr->length + COMPOSITE_INCREMENT));
    _check_alloc(comp_ptr->elements);
  }

  elem_ptr = comp_ptr->elements + comp_ptr->length;
  elem_ptr->id = id;
  elem_ptr->value = val;
  comp_ptr->length += 1;

  return 1;
}

struct _value _binop_get_char(struct _value op1, int index)
{
  if (op1.type != TYP_STRING) {
    _fatal(ERR_TYPE, "wrong type for string: %s", _type_str(op1.type));
  }

  char *op1_cptr = *((char **) &(op1.value));
  size_t op1_len = strlen(op1_cptr);

  struct _value ret;
  memset(&ret, 0, sizeof(ret));

  if (index < 0 || index >= op1_len) {
    ret.type = TYP_NULL;
    return ret;
  }

  char *buf = calloc(2, sizeof(char));
  _check_alloc(buf);
  memset(buf, 0, 2 * sizeof(char));
  buf[0] = op1_cptr[index];

  ret.type = TYP_STRING;
  memcpy(&(ret.value), &buf, sizeof(char *));

  return ret;
}

struct _value _binop_get_value(struct _value op1, struct _value op2)
{
  if (op1.type == TYP_STRING) {
    _binop_typecheck("[", op1, TYP_STRING, op2, TYP_NUMBER);
    return _binop_get_char(op1, (int) op2.value);
  }

  if (op1.type == TYP_OBJECT) {
    _binop_typecheck(".", op1, TYP_OBJECT, op2, TYP_NUMBER);
    return _func_get_element(op1, (int) op2.value);
  }

  _binop_typecheck("[", op1, TYP_ARRAY, op2, TYP_NUMBER);
  return _func_get_element(op1, (int) op2.value);
}


/*
 * Other operators: [?], ^
 */

struct _value _unop_len(struct _value op1)
{
  if (op1.type == TYP_STRING) {
    char *op1_cptr = *((char **) &(op1.value));
    size_t op1_len = strlen(op1_cptr);
    return (struct _value) {TYP_NUMBER, (double) op1_len};
  }

  _unop_typecheck("", op1, TYP_ARRAY, "[?]");

  struct _composite *comp_ptr = *((struct _composite **) &(op1.value));
  int max_id = 0;
  for (int i = 0; i < comp_ptr->length; ++i) {
    struct _element *elem = comp_ptr->elements + i;
    if (elem->id > max_id) {
      max_id = elem->id;
    }
  }

  return (struct _value) {TYP_NUMBER, (double) max_id};
}

struct _value _binop_concat(struct _value op1, struct _value op2)
{
  _binop_typecheck("^", op1, TYP_STRING, op2, TYP_STRING);

  const char *op1_cptr = *((char **) &(op1.value));
  size_t op1_len = strlen(*((char **) &(op1.value)));

  const char *op2_cptr = *((char **) &(op2.value));
  size_t op2_len = strlen(*((char **) &(op2.value)));

  size_t buf_sz = op1_len + op2_len + 1;
  char *buf = calloc(op1_len + op2_len + 1, sizeof(char));
  _check_alloc(buf);

  memset(buf, 0, buf_sz);
  strncpy(buf, op1_cptr, op1_len);
  strncpy(buf + op1_len, op2_cptr, op2_len);

  struct _value ret;
  memset(&ret, 0, sizeof(ret));
  ret.type = TYP_STRING;
  memcpy(&(ret.value), &buf, sizeof(char *));

  return ret;
}


/*
 * Built-ins: print, main
 */

int _func_print_composite(struct _value);

int _func_print(struct _value val)
{
  switch (val.type) {
    case TYP_VOID:
      return 0;
    case TYP_NULL:
      return fprintf(stdout, "null");
    case TYP_BOOLEAN:
      return fprintf(stdout, "%s", val.value != FALSE ? "true" : "false");
    case TYP_NUMBER:
      if (ceil(val.value) == val.value) {
        return fprintf(stdout, "%ld", (long) ceil(val.value));
      }
      return fprintf(stdout, "%f", val.value);
    case TYP_STRING:
      return fprintf(stdout, "%s", *((char **) &(val.value)));
    case TYP_OBJECT:
      return fprintf(stdout, "{ ")
        + _func_print_composite(val)
        + fprintf(stdout, " }");
    case TYP_ARRAY:
      return fprintf(stdout, "[ ")
        + _func_print_composite(val)
        + fprintf(stdout, " ]");
    default:
      _fatal(ERR_BUG, "unknown type code: %d", val.type);
      return 0;
  };
}

int _func_print_composite(struct _value comp)
{
  if (comp.type != TYP_OBJECT && comp.type != TYP_ARRAY) {
    _fatal(ERR_TYPE, "wrong type for composite: %s", _type_str(comp.type));
  }

  int char_count = 0;
  struct _composite *comp_ptr = *((struct _composite **) &(comp.value));
  for (int i = 0; i < comp_ptr->length; ++i) {
    struct _element *elem_ptr = comp_ptr->elements + i;
    if (i > 0) {
      char_count += fprintf(stdout, ", %d: ", elem_ptr->id);
    } else {
      char_count += fprintf(stdout, "%d: ", elem_ptr->id);
    }
    char_count += _func_print(elem_ptr->value);
  }

  return char_count;
}

extern struct _value jijo(struct _value);

int main(int argc, char**argv)
{
  struct _value this;
  this.type = TYP_NULL;
  this.type = 0.0;

  struct _value ret = jijo(this);
  return _func_print(ret);
}

