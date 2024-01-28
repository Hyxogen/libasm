BITS 64
extern __errno_location
global ft_write

ft_write:
  push rbx
  push r12

  mov rax, 1 ; write syscall 
  mov r8, rbx ; save rbx
  mov rbx, rdi ; fd
  mov rcx, rsi ; buf
  ; num bytes is already in rdx
  syscall
  test rax, rax
  jns .end
  mov r12, rax
  neg r12 ; get errno number
  call __errno_location wrt ..plt
  mov [rax], r12
  mov rax, -1
.end:
  pop r12
  pop rbx
  ret
