NAME		:= libasm.a

AR		:= ar
ASM 		:= nasm

OBJ_DIR		:= build

SRC_FILES	:= strlen.s strcpy.s strcmp.s strdup.s read.s write.s atoi_base.s push_front.s
OBJ_FILES	:= $(patsubst %.s,$(OBJ_DIR)/%.o,$(SRC_FILES))

.PHONY: all clean fclean re check

all: $(NAME)

$(NAME): $(OBJ_FILES)
	rm -f $@
	ar rcs $@ $(OBJ_FILES)

$(OBJ_DIR)/%.o: %.s Makefile
	@mkdir -p $(@D)
	$(ASM) $< -o $@ -f elf64 -g

check: $(NAME) Makefile
	$(CC) -g test.c -o $@ $(NAME)
	./$@

clean:
	rm -rf $(OBJ_DIR)

fclean:
	${MAKE} clean
	rm -f $(NAME)

re:
	${MAKE} fclean
	${MAKE}
