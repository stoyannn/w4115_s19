#define TYP_VOID    0
#define TYP_NULL    1
#define TYP_BOOLEAN 2
#define TYP_NUMBER  3
#define TYP_STRING  4
#define TYP_OBJECT  5
#define TYP_ARRAY   6

#define ERR_TYPE 101
#define ERR_VAL  102

struct _value {
  unsigned char type;
  double value;
};

