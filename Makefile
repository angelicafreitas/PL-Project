CC = gcc
FLEXC = lex
GLIB =`pkg-config --cflags --libs glib-2.0`
FLAGS = -Wall -Wextra -Wshadow -pedantic -Wno-unused-function -Wno-unused-parameter
OUT_1 = extraiGIC
OUT_2 = lexgen
SRC_FLEX_1 = extraiGIC.l
SRC_FLEX_2 = lexgen.l
SRC = lex.yy.c


all:
	$(FLEXC) $(SRC_FLEX_1)
	$(CC) ${FLAGS} $(SRC) -o $(OUT_1) ${GLIB}
	$(FLEXC) $(SRC_FLEX_2)
	$(CC) ${FLAGS} $(SRC) -o $(OUT_2) ${GLIB}
    
run: all
	./$(OUT_1) f.y
	./$(OUT_2) f.y
clean:
	rm -rf ${OUT_1} ${OUT_2}



