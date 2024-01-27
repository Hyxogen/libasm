#include "libasm.h"
#include <assert.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <limits.h>

#include <stdio.h>

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

static void check_read()
{
  char a[1024], b[1024];

  memset(a, 0, sizeof a);
  memset(b, 0, sizeof b);
  assert(ft_read(-1, NULL, 0) == -1);
  assert(errno == EBADF);

  int dev = open("/", O_RDONLY);
  assert(dev >= 0);
  assert(ft_read(dev, a, sizeof a) == -1);
  assert(errno == EISDIR);
  assert(!close(dev));

  int make = open("Makefile", O_RDONLY);
  ssize_t theirs = read(make, a, sizeof a);

  assert(theirs != -1);
  assert(lseek(make, 0, SEEK_SET) != -1);

  assert(ft_read(make, b, sizeof b) == theirs);
  assert(!strncmp(a, b, sizeof a));

  assert(!close(make));
}

static void check_write()
{
  assert(ft_write(-1, "hallo", 5) == -1);
  assert(errno == EBADF);

  int dev = open("/", O_RDONLY);
  assert(dev >= 0);
  assert(ft_read(dev, "hallo", 5) == -1);
  assert(errno == EISDIR);
  assert(!close(dev));

  char str[] = "Hello world!";
  int fd = open("tmp", O_RDWR | O_CREAT | O_EXCL);
  assert(fd != -1);

  assert(ft_write(fd, str, sizeof str) == sizeof str);
  assert(lseek(fd, 0, SEEK_SET) != -1);

  char buf[128];
  assert(read(fd, buf, sizeof buf) == sizeof str);
  assert(!memcmp(str, buf, sizeof buf > sizeof str ? sizeof str : sizeof buf));
  assert(!close(fd));

  assert(unlink("tmp") != -1);
}

static void check_atoi_base()
{
  const char *base10 = "0123456789";
  const char *base2 = "01";
  const char *base8 = "01234567";
  const char *base16 = "0123456789abcdef";

  assert(ft_atoi_base("", "") == 0);
  assert(ft_atoi_base("0", base10) == 0);
  assert(ft_atoi_base("00", base10) == 0);
  assert(ft_atoi_base("1", base10) == 1);
  assert(ft_atoi_base("01", base10) == 1);
  assert(ft_atoi_base("-1", base10) == -1);
  assert(ft_atoi_base("--1", base10) == 1);
  assert(ft_atoi_base("2147483647", base10) == 2147483647);
  assert(ft_atoi_base("   --2147483647", base10) == 2147483647);
  assert(ft_atoi_base("-2147483648", base10) == INT_MIN);
  assert(ft_atoi_base("---2147483647", base10) == -2147483647);
  assert(ft_atoi_base("7fffffff", base16) == 0x7fffffff);
  assert(ft_atoi_base("-f", base16) == -15);
  assert(ft_atoi_base("-7fffffff", base16) == -0x7fffffff);
  assert(ft_atoi_base(" 0 1", base2) == 0);
  assert(ft_atoi_base(" 01", base2) == 1);
  assert(ft_atoi_base("8", base8) == 0);
}

static void check_push_front() {
  t_list *list = NULL;

  int i = 42;
  ft_list_push_front(&list,  &i);
  assert(list);
  assert(list->data == &i);
  assert(list->next == NULL);

  t_list *tmp = list;
  int j = 21;
  ft_list_push_front(&list, &j);
  assert(list);
  assert(list->data == &j);
  assert(list->next == tmp);
  assert(list->next->data == &i);
  assert(list->next->next == NULL);
}

static void check_list_size() {
  t_list *list = NULL;

  for (int i = 0; i < 10; ++i) {
    assert(ft_list_size(list) == i);
    ft_list_push_front(&list, NULL);
  }
}

int main()
{
  check_strlen();
  check_strcpy();
  check_strcmp();
  check_strdup();
  check_read();
  check_atoi_base();
  check_push_front();
  check_list_size();
}
