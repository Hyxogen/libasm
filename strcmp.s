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
  mov rax, -1
.loop:
  inc rax
  mov dl, byte [rdi + rax]
  mov dh, byte [rsi + rax]
  cmp dl, dh
  jnz .end
  test dl, dl
  jnz .loop
.end
  sub dl, dh
  movsx rax, dl
  ret
