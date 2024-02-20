BITS 64
global ft_strdup

extern ft_strlen, ft_strcpy, malloc

; char* ft_strdup(const char *s)
; {
;   size_t n = ft_strlen(s) + 1;
;   char *p = malloc(n);
;   if (p)
;     ft_strcpy(p, s);
;   return p;
; }

ft_strdup:
  push rbx
  mov rbx, rdi
  call ft_strlen
  mov rdi, rax
  inc rdi
  call malloc wrt ..plt
  test rax, rax
  jz .end
  mov rdi, rax
  mov rsi, rbx
  call ft_strcpy
.end:
  pop rbx
  ret
