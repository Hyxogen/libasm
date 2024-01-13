#include "libasm.h"
#include <assert.h>
#include <string.h>
#include <stdlib.h>

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

static void check_strcmp()
{
  assert(ft_strcmp("", "") == 0);
  assert(ft_strcmp("hello", "hello") == 0);
  assert(ft_strcmp("ab", "ac") < 0);
  assert(ft_strcmp("ac", "ab") > 0);
  assert(ft_strcmp("abc", "acc") < 0);
  assert(ft_strcmp("acc", "abc") > 0);
}

static void check_strdup_one(const char *s)
{
  char *d = ft_strdup(s);
  assert(!strcmp(d, s));
  free(d);
}

static void check_strdup()
{
  check_strdup_one("");
  check_strdup_one("hallo");
}

int main()
{
  check_strlen();
  check_strcpy();
  check_strcmp();
  check_strdup();
}
