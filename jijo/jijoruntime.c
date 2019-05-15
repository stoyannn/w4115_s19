#include <execinfo.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "jijoruntime.h"


/*
 * Support functions
 */

char* _type_str(struct _value *val) {
  switch(val->type) {
    case TYP_VOID:
      return "void";
    case TYP_BOOLEAN:
      return "boolean";
    case TYP_NUMBER:
      return "number";
    case TYP_STRING:
      return "string";
    case TYP_ARRAY:
      return "array";
    case TYP_OBJECT:
      return "object";
    default:
      return "unknown";
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

void _binop_typecheck(char *op, struct _value *op1, unsigned char typ1,
	struct _value *op2, unsigned char typ2)
{
  if (op1->type != typ1 || op2->type != typ2) {
    _fatal(ERR_TYPE, "wrong operand types: %s %s %s", _type_str(op1), op, _type_str(op2));
  }
}

void _unop_typecheck(char *preop, struct _value *op1, unsigned char typ1, char *postop)
{
  if (op1->type != typ1) {
    _fatal(ERR_TYPE, "wrong operand type: %s %s %s", preop, _type_str(op1), postop);
  }
}


/*
 * Arithmetic operators: +, -, *, /, unary -
 */

struct _value _binop_plus(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("+", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1->type, op1->value + op2->value};
}

struct _value _binop_minus(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("-", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1->type, op1->value - op2->value};
}

struct _value _binop_mult(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("*", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1->type, op1->value * op2->value};
}

struct _value _binop_div(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("/", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {op1->type, op1->value / op2->value};
}

struct _value _unop_uminus(struct _value *op1)
{
  _unop_typecheck("-", op1, TYP_NUMBER, "");
  return (struct _value) {op1->type, -(op1->value)};
}


/*
 * Comparison operators: ==, !=, <, <=, >, >=
 */

struct _value _binop_equal(struct _value *op1, struct _value *op2)
{
  if (op1->type != op2->type) {
    return (struct _value) {TYP_BOOLEAN, FALSE};
  }
  if (op1->type == TYP_VOID || op1->type == TYP_NULL) {
    return (struct _value) {TYP_BOOLEAN, TRUE};
  }
  if (op1->type == TYP_BOOLEAN) {
    return (struct _value) {TYP_BOOLEAN,
	    (op1->value != FALSE) == (op2-> value != FALSE) ? TRUE : FALSE};
  }
  return (struct _value) {TYP_BOOLEAN, op1->value == op2->value ? TRUE : FALSE};
}

struct _value _binop_nequal(struct _value *op1, struct _value *op2)
{
  struct _value ret = _binop_equal(op1, op2);
  ret.value = ret.value != FALSE ? FALSE : TRUE;
  return ret;
}

struct _value _binop_less(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("<", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1->value < op2->value ? TRUE : FALSE};
}

struct _value _binop_lequal(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("<=", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1->value <= op2->value ? TRUE : FALSE};
}

struct _value _binop_grtr(struct _value *op1, struct _value *op2)
{
  _binop_typecheck(">", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1->value > op2->value ? TRUE : FALSE};
}

struct _value _binop_grequal(struct _value *op1, struct _value *op2)
{
  _binop_typecheck(">=", op1, TYP_NUMBER, op2, TYP_NUMBER);
  return (struct _value) {TYP_BOOLEAN, op1->value >= op2->value ? TRUE : FALSE};
}


/*
 * Logical operators: &&, ||, !, is
 */

struct _value _binop_and(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("&&", op1, TYP_BOOLEAN, op2, TYP_BOOLEAN);
  return (struct _value) {TYP_BOOLEAN,
	  (op1->value != FALSE)  && (op2->value) != FALSE ? TRUE : FALSE};
}

struct _value _binop_or(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("||", op1, TYP_BOOLEAN, op2, TYP_BOOLEAN);
  return (struct _value) {TYP_BOOLEAN,
	  (op1->value != FALSE) || (op2->value != FALSE) ? TRUE : FALSE};
}

struct _value _unop_not(struct _value *op1)
{
  _unop_typecheck("!", op1, TYP_BOOLEAN, "");
  return (struct _value) {TYP_BOOLEAN, op1->value != FALSE ? FALSE : TRUE};
}

struct _value _binop_is(struct _value *op1, struct _value *op2)
{
  return (struct _value) {TYP_BOOLEAN, op1->type == op2->type ? TRUE : FALSE};
}


/*
 * Object field and array element access
 */

struct _value _binop_get_string(struct _value *op1, int index)
{
  char *op1_cptr = *((char **) &(op1->value));
  size_t op1_len = strlen(op1_cptr);

  struct _value ret;
  memset(&ret, 0, sizeof(ret));

  if (index < 0 || index >= op1_len) {
    ret.type = TYP_NULL;
    return ret;
  }

  char *buf = calloc(2, sizeof(char));
  if (buf == NULL) {
    _fatal(ERR_MEM, "memory allocation error");
  }

  memset(buf, 0, 2 * sizeof(char));
  buf[0] = op1_cptr[index];

  ret.type = TYP_STRING;
  memcpy(&(ret.value), &buf, sizeof(char *));

  return ret;
}

struct _value _binop_get_composite(struct _value *op1, int index)
{
  struct _value ret;
  memset(&ret, 0, sizeof(ret));

  struct _composite *comp_ptr = *((struct _composite **) &(op1->value));
  if (index < 0 || index >= comp_ptr->length) {
    ret.type = TYP_NULL;
    return ret;
  }

  for (int i = 0; i < comp_ptr->length; ++i) {
    struct _element *elem = comp_ptr->values + i;
    if (elem->index == index) {
      return elem->value;
    }
  }

  ret.type = TYP_NULL;
  return ret;
}

struct _value _binop_index(struct _value *op1, struct _value *op2)
{
  if (op1->type == TYP_STRING) {
    _binop_typecheck("[", op1, TYP_STRING, op2, TYP_NUMBER);
    return _binop_get_string(op1, (int) op2->value);
  }

  if (op1->type == TYP_OBJECT) {
    _binop_typecheck(".", op1, TYP_OBJECT, op2, TYP_NUMBER);
    return _binop_get_composite(op1, (int) op2->value);
  }

  _binop_typecheck("[", op1, TYP_ARRAY, op2, TYP_NUMBER);
  return _binop_get_composite(op1, (int) op2->value);
}


/*
 * Other operators: [?], ^
 */

struct _value _unop_len(struct _value *op1)
{
  if (op1->type == TYP_STRING) {
    char *op1_cptr = *((char **) &(op1->value));
    size_t op1_len = strlen(op1_cptr);
    return (struct _value) {TYP_NUMBER, (double) op1_len};
  }

  _unop_typecheck("", op1, TYP_ARRAY, "[?]");

  struct _composite *comp_ptr = *((struct _composite **) &(op1->value));
  int max_index = 0;
  for (int i = 0; i < comp_ptr->length; ++i) {
    struct _element *elem = comp_ptr->values + i;
    if (elem->index > max_index) {
      max_index = elem->index;
    }
  }

  return (struct _value) {TYP_NUMBER, (double) max_index};
}

struct _value _binop_concat(struct _value *op1, struct _value *op2)
{
  _binop_typecheck("^", op1, TYP_STRING, op2, TYP_STRING);

  const char *op1_cptr = *((char **) &(op1->value));
  size_t op1_len = strlen(*((char **) &(op1->value)));

  const char *op2_cptr = *((char **) &(op2->value));
  size_t op2_len = strlen(*((char **) &(op2->value)));

  size_t buf_sz = op1_len + op2_len + 1;
  char *buf = calloc(op1_len + op2_len + 1, sizeof(char));
  if (buf == NULL) {
    _fatal(ERR_MEM, "memory allocation error");
  }

  memset(buf, 0, buf_sz);
  strncpy(buf, op1_cptr, op1_len);
  strncpy(buf + op1_len, op2_cptr, op2_len);

  struct _value ret;
  memset(&ret, 0, sizeof(ret));
  ret.type = TYP_STRING;
  memcpy(&(ret.value), &buf, sizeof(char *));

  return ret;
}

