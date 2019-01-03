#include "mylib.h"
#include <math.h>

double MySqrt(double x)
{
  if( x < 0. )
  {
    throw("#Negative argument");
  }
  return sqrt(x);
}
