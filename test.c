#include "libasm.h"
#include <assert.h>
#include <string.h>

static void check_strlen()
{
  assert(ft_strlen("") == 0);
  assert(ft_strlen("a") == 1);
  assert(ft_strlen("hello world") == 11);
  assert(ft_strlen("hello\0 world") == 5);
}

static void check_strcpy()
{
  char buffer[1024];
  char tmp[1024];

  memset(buffer, 0, sizeof buffer);
  memset(tmp, 0, sizeof tmp);
  assert(ft_strcpy(buffer, "") == buffer);
  assert(memcmp(buffer, tmp, sizeof tmp) == 0);

  const char *str1 = "hello world!";
  assert(ft_strcpy(buffer, str1) == buffer);
  assert(strcmp(buffer, str1) == 0);

  memset(buffer, 0, sizeof buffer);
  const char *str2 = "hello\0 world!";
  assert(ft_strcpy(buffer, str2) == buffer);
  assert(strcmp(buffer, str2) == 0);
}

int main()
{
  check_strlen();
  check_strcpy();
}
