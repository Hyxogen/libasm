BITS 64
global ft_strcmp

; int strcmp(const char *s1, const char *s2)
; {
;   const unsigned char *u1 = (const unsigned char *) s1;
;   const unsigned char *u2 = (const unsigned char *) s2;
; 
;   while (*u1 && *u1 == *u2) {
;     ++u1;
;     ++u2;
;   }
;   return *u1 - *u2;
; }

ft_strcmp:
  mov rdx, -1
.loop:
  inc rdx
  movzx rax, byte [rdi + rdx]
  movzx rcx, byte [rsi + rdx]
  cmp rax, rcx
  jnz .end
  test rax, rax
  jnz .loop
.end:
  sub rax, rcx
  ret
