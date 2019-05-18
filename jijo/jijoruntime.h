#define TYP_VOID    0
#define TYP_NULL    1
#define TYP_BOOLEAN 2
#define TYP_NUMBER  3
#define TYP_STRING  4
#define TYP_OBJECT  5
#define TYP_ARRAY   6

#define ERR_TYPE 101
#define ERR_VAL  102
#define ERR_MEM  103
#define ERR_BUG  104

#define TRUE  1.0
#define FALSE 0.0

#define COMPOSITE_INCREMENT 16

struct _value {
  unsigned char type;
  double value;
};

struct _element {
  int id;
  struct _value value;
};

struct _composite {
  int length;
  struct _element *elements;
};

