BITS 64
global ft_strlen

ft_strlen:
  mov rax, -16
  pxor xmm0, xmm0
.loop:
  add rax, 16
  pcmpistri xmm0, oword [rdi + rax], 0b00001000
  jnz .loop
  add rax, rcx
  ret
