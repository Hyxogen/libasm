BITS 64
global ft_list_sort

; void ft_list_sort(t_list **begin_list, int (*cmp)())
; {
;   t_list *prv = NULL;
;   t_list *cur = *begin_list;
;   while (cur && cur->next) {
;     if (cmp(cur->data, cur->next->data) > 0) {
;       t_list *tmp = cur->next;
;       cur->next = cur->next->next;
;       tmp->next = cur;
; 
;       if (prv)
;         prv->next = tmp;
;       else
;         *begin_list = tmp;
; 
;       prv = NULL;
;       cur = *begin_list;
;     } else {
;       prv = cur;
;       cur = cur->next;
;     }
;   }
; }

ft_list_sort:
  push rbp
  mov rbp, rsp

  push rbx ; cur
  push r12 ; cmp
  push r13 ; prv
  push r14 ; tmp
  push r15 ; begin_list
  mov rbx, [rdi]
  mov r12, rsi
  xor r13, r13
  mov r15, rdi

  jmp .loop_check

.loop_body:
  mov rdi, [rbx]
  mov rsi, [rbx + 8]
  mov rsi, [rsi]
  call r12

  test eax, eax
  jle .sorted

  mov r14, [rbx + 8]
  mov rsi, [rbx + 8]
  mov rsi, [rsi + 8]
  mov [rbx + 8], rsi
  mov [r14 + 8], rbx

  test r13, r13
  jz .update_begin

  mov [r13 + 8], r14
  jmp .reset

.update_begin:
  mov [r15], r14

.reset:
  xor r13, r13
  mov rbx, [r15]
  jmp .loop_check

.sorted:
  mov r13, rbx
  mov rbx, [rbx + 8]
.loop_check:
  test rbx, rbx
  jz .end
  mov rdi, [rbx + 8] ; TODO try cmp [rbx + 8], 0
  test rdi, rdi
  jnz .loop_body

.end:
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  pop rbp
  ret
