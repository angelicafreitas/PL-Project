CC = gcc
FLEXC = lex
FLAGS = -Wall -Wextra -Wshadow -pedantic
OUT_1 = extraiGIC
OUT_2 = lexgen
SRC_FLEX_1 = extraiGIC.l
SRC_FLEX_2 = lexgen.l
SRC = lex.yy.c

all:
	$(FLEXC) $(SRC_FLEX_1)
	$(CC) $(SRC) -o $(OUT_1)
	$(FLEXC) $(SRC_FLEX_2)
	$(CC) $(SRC) -o $(OUT_2)
    
run: all
	./$(OUT_1) f.y
	./$(OUT_2) f.y
clean:
	rm -rf ${OUT_1} ${OUT_2}



