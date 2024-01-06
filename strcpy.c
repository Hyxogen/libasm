char* ft_strcpy(char *dest, const char *src)
{
  char *tmp = dest;
  while ((*dest++ = *src++))
    continue;
  return tmp;
}
