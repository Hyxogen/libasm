BITS 64
extern __errno_location
global ft_read

ft_read:
  xor rax, rax ; read syscall
  mov r8, rbx ; save rbx
  mov rbx, rdi ; fd
  mov rcx, rsi ; buf
  ; num bytes is already in rdx
  syscall
  test rax, rax
  jns .end
  mov rcx, rax
  neg rcx ; get errno number
  call __errno_location wrt ..plt
  mov [ rax ], rcx
  mov rax, -1
.end:
  mov rbx, r8 ; restore rbx
  ret
