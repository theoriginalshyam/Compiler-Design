LEX = flex
CC = gcc
SRC_DIR = src
LEXER = $(SRC_DIR)/lexer.l
LEXER_C = $(SRC_DIR)/lex.yy.c
BIN = lexer

all: $(BIN)

$(BIN): $(LEXER)
	$(LEX) -o $(LEXER_C) $(LEXER)
	$(CC) $(LEXER_C) -o $(BIN)

clean:
	rm -f $(LEXER_C) $(BIN)

.PHONY: all clean
