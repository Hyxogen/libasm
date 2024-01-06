BITS 64
global ft_strcpy

ft_strcpy:
  mov rax, rdi
  xor rcx, rcx
.loop:
  mov dl, byte [rsi + rcx]
  mov byte [rdi + rcx], dl
  inc rcx
  cmp dl, 0
  jne .loop
  ret
