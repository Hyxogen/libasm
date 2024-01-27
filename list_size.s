BITS 64
global ft_list_size

; int ft_list_size(t_list *begin_list)
; {
;   int i = 0;
;   while (*begin_list) {
;     *begin_list = begin_list->next;
;     ++i;
;   }
;   return i;
; }

ft_list_size:
  xor rax, rax
  jmp .loop_start
.loop_body:
  mov rdi, [rdi + 0x8]
  inc rax
.loop_start:
  test rdi, rdi
  jnz .loop_body
  ret
