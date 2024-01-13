#ifndef LIBASM_H
#define LIBASM_H

#include <stddef.h>
#include <sys/types.h>

size_t ft_strlen(const char *s);
char *ft_strcpy(char *dest, const char *src);
int ft_strcmp(const char *a, const char *b);
char *ft_strdup(const char *s);
ssize_t ft_read(int fd, char *buffer, size_t n);
ssize_t ft_write(int fd, const char *buffer, size_t n);

#endif
