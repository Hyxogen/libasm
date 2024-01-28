BITS 64
global ft_strcmp

ft_strcmp:
  mov rdx, rsi
  sub rdx, rdi
  sub rdi, 16
.loop:
  add rdi, 16
  movdqu xmm0, oword [rdi]
  pcmpistri xmm0, oword [rdi + rdx], 0b00011000
  ja .loop
  jc .diff

  xor rax, rax
  ret
.diff:
  add rdx, rcx
  movzx rax, byte [rdi + rcx]
  movzx rdx, byte [rdi + rdx]
  sub rax, rdx
  ret
