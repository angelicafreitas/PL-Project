CC = gcc
FLEXC = lex
FLAGS = -Wall -Wextra -Wshadow -pedantic
OUT = extraiGIC
SRC_FLEX = extraiGIC.l
SRC = lex.yy.c

all:
	$(FLEXC) $(SRC_FLEX)
	$(CC) $(SRC) -o $(OUT)
    
run: all
	./$(OUT) f.y
clean:
	rm -rf $(OUT)



