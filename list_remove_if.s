BITS 64
global ft_list_remove_if
extern free

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; {
;   t_list *prv = NULL;
;   t_list *cur = *begin_list;
;   while (cur)
;   {
;     t_list *nxt = cur->next;
;     if (!cmp(cur->data, data_ref)) {
;       if (prv)
;         prv->next = nxt;
;       else
;         *begin_list = nxt;
; 
;       free_fct(cur->data);
;       free(cur);
;     } else {
;       prv = cur;
;     }
;     cur = nxt;
;   }
; }

ft_list_remove_if:
  push rbx ; begin_list
  push r12 ; data_ref
  push r13 ; cmp
  push r14 ; free_fct
  push r15 ; cur
  push rbp ; prv

  mov rbx, rdi
  mov r12, rsi
  mov r13, rdx
  mov r14, rcx
  mov r15, [rbx]
  xor rbp, rbp

  jmp .loop_check
.loop_body:
  mov rdi, [r15]
  mov rsi, r12
  call r13
  test eax, eax

  mov rdi, [r15 + 8] ; nxt
  jnz .update_prv
  test rbp, rbp
  jz .update_beg

  mov [rbp + 8], rdi
  jmp .free
.update_beg:
  mov [rbx], rdi ; nxt
  jmp .free
.free:
  push rdi
  mov rdi, [r15]
  call r14
  mov rdi, r15
  call free wrt ..plt
  pop rdi
  jmp .next
.update_prv:
  mov rbp, r15
.next:
  mov r15, rdi

.loop_check:
  test r15, r15
  jnz .loop_body

  pop rbp
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  ret
