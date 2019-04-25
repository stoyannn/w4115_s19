#include <execinfo.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "jijoruntime.h"

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

void _fatal(int code, const char *format, ...) {
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

void _binop_typecheck(char *op, unsigned char type, struct _value *op1, struct _value *op2) {
  if (op1->type != type || op2->type != type) {
    _fatal(ERR_TYPE, "wrong operand types: %s %s %s", _type_str(op1), op, _type_str(op2));
  }
}

struct _value _binop_plus(struct _value op1, struct _value op2) {
  _binop_typecheck("+", TYP_NUMBER, &op1, &op2);
  return (struct _value) {op1.type, op1.value + op2.value};
}

struct _value _binop_minus(struct _value op1, struct _value op2) {
  _binop_typecheck("-", TYP_NUMBER, &op1, &op2);
  return (struct _value) {op1.type, op1.value - op2.value};
}

struct _value _binop_mult(struct _value op1, struct _value op2) {
  _binop_typecheck("*", TYP_NUMBER, &op1, &op2);
  return (struct _value) {op1.type, op1.value * op2.value};
}

struct _value _binop_div(struct _value op1, struct _value op2) {
  _binop_typecheck("/", TYP_NUMBER, &op1, &op2);
  return (struct _value) {op1.type, op1.value / op2.value};
}

struct _value _binop_equal(struct _value op1, struct _value op2) {
  if (op1.type != op2.type) {
    return (struct _value) {TYP_BOOLEAN, 0.0};
  }
  if (op1.type == TYP_VOID || op1.type == TYP_NULL) {
    return (struct _value) {TYP_BOOLEAN, op1.type == op2.type};
  }
  return (struct _value) {TYP_BOOLEAN, op1.type == op2.type && op1.value == op2.value};
}

struct _value _binop_nequal(struct _value op1, struct _value op2) {
  if (op1.type != op2.type) {
    return (struct _value) {TYP_BOOLEAN, 0.0};
  } else if (op1.type == TYP_VOID || op1.type == TYP_NULL) {
    return (struct _value) {TYP_BOOLEAN, 1.0};
  }
  return (struct _value) {TYP_BOOLEAN, op1.type != op2.type || op1.value != op2.value};
}

struct _value _binop_less(struct _value op1, struct _value op2) {
  _binop_typecheck("<", TYP_NUMBER, &op1, &op2);
  return (struct _value) {TYP_BOOLEAN, op1.value < op2.value};
}

struct _value _binop_lequal(struct _value op1, struct _value op2) {
  _binop_typecheck("<=", TYP_NUMBER, &op1, &op2);
  return (struct _value) {TYP_BOOLEAN, op1.value <= op2.value};
}

struct _value _binop_grtr(struct _value op1, struct _value op2) {
  _binop_typecheck(">", TYP_NUMBER, &op1, &op2);
  return (struct _value) {TYP_BOOLEAN, op1.value <= op2.value};
}

struct _value _binop_grequal(struct _value op1, struct _value op2) {
  _binop_typecheck(">=", TYP_NUMBER, &op1, &op2);
  return (struct _value) {TYP_BOOLEAN, op1.value <= op2.value};
}

struct _value _binop_and(struct _value op1, struct _value op2) {
  _binop_typecheck("&&", TYP_BOOLEAN, &op1, &op2);
  return (struct _value) {TYP_BOOLEAN, op1.value && op2.value};
}

struct _value _binop_or(struct _value op1, struct _value op2) {
  _binop_typecheck("||", TYP_BOOLEAN, &op1, &op2);
  return (struct _value) {TYP_BOOLEAN, op1.value || op2.value};
}

struct _value _binop_is(struct _value op1, struct _value op2) {
  return (struct _value) {TYP_BOOLEAN, op1.type == op2.type};
}

int main(int argc, char *argv[]) {
  struct _value val;
  _binop_minus((struct _value) {TYP_BOOLEAN, 5.0}, (struct _value) {TYP_VOID, 3.0});
  return 0;
}

