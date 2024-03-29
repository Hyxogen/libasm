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
int ft_atoi_base(const char *s, const char *base);

typedef struct s_list {
  void *data;
  struct s_list *next;
} t_list;

void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);
void ft_list_sort(t_list **begin_list, int (*cmp)());
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

#endif
