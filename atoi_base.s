BITS 64
global ft_atoi_base
extern ft_strlen

; int ft_atoi_base(const char *s, const char *base)
; {
;   long res = 0;
;   int sign = 1;
; 
;   while (isspace(*s))
;     ++s;
;   while (*s == '-' || *s == '+') {
;     if (*s == '-')
;       sign = -sign;
;     ++s;
;   }
;   const char *p;
;   size_t len = strlen(base);
;   while (*s && (p = strchr(base, *s))) {
;     res = res * len + (p - base);
;     ++s;
;   }
;   return res * sign;
; }

ft_isspace:
  cmp edi, 0x20
  sete al
  sub edi, 0x09
  cmp edi, 5
  setb cl
  or cl, al
  movzx eax, cl
  ret

ft_atoi_base:
  push rbp
  mov rbp, rsp

  push rbx
  push r12
  push r13
  push r14

  mov rbx, rdi ; str
  mov r12, rsi ; base
  mov r13, 1 ; sign

  jmp .is_space

.skip_ws:
  inc rbx
.is_space:
  movzx edi, byte [rbx]
  call ft_isspace
  test eax, eax
  jnz .skip_ws

  jmp .is_sign

.skip_neg_sign:
  neg r13
.skip_sign:
  inc rbx
.is_sign:
  mov al, byte [rbx]
  cmp al, 0x2d ; check if '-'
  je .skip_neg_sign
  cmp al, 0x2b ; check if '+'
  je .skip_sign

  mov rdi, r12
  call ft_strlen
  mov r14, rax ; base len

  xor rax, rax ; result

.loop:
  mov cl, byte [rbx]
  test cl, cl
  jz .end

  xor rdi, rdi
  jmp .base_loop
.base_loop_inc:
  inc rdi
.base_loop:
  mov dl, byte [r12 + rdi]
  test dl, dl
  jz .end

  cmp cl, dl
  jnz .base_loop_inc
  mul r14
  add rax, rdi
  inc rbx
  jmp .loop

.end:
  mul r13 ; result * sign

  pop r14
  pop r13
  pop r12
  pop rbx
  pop rbp

  ret
