BITS 64
global ft_strlen

ft_strlen:
  mov rax, -1
.loop:
  cmp byte [rdi + rax + 1], 0
  lea rax, [rax + 1]
  jne .loop
  ret
