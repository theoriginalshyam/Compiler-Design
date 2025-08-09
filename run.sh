#!/bin/bash

LEXER=./lexer
TEST_DIR=test
OUTPUT_DIR=test/output

mkdir -p $OUTPUT_DIR

for testfile in $TEST_DIR/*.txt
do
    filename=$(basename "$testfile" .txt)
    echo "Running $filename"
    $LEXER "$testfile" "$OUTPUT_DIR/${filename}_error.txt" > "$OUTPUT_DIR/${filename}_output.txt"
done
