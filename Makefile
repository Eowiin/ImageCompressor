##
## EPITECH PROJECT, 2022
## ImageCompressor
## File description:
## Makefile
##

BINARY_PATH 	=	$(shell stack path --local-install-root)
NAME	=	imageCompressor

all:
	stack build
	cp $(BINARY_PATH)/bin/$(NAME)-exe ./$(NAME)

clean:
	stack clean

fclean:	clean
	$(RM) $(NAME)

re:	fclean all

.PHONY:	all clean fclean re
