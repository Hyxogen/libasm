BITS 64
global ft_list_push_front
extern malloc

; void ft_list_push_front(t_list **begin_list, void *data)
; {
;   t_list *link = malloc(sizeof t_list);
;   if (!link)
;     return;
;
;   link->data = data;
;   link->next = *begin_list;
;
;   *begin_list = link;
; }

ft_list_push_front:
  push rbp
  mov rbp, rsp

  push rbx
  push r12
  mov rbx, rdi
  mov r12, rsi

  mov rdi, 0x10
  call malloc wrt ..plt
  test rax, rax
  jz .end

  mov [rax], r12
  mov rsi, [rbx]
  mov [rax + 0x8], rsi
  mov [rbx], rax
.end:
  pop r12
  pop rbx
  pop rbp
  ret
