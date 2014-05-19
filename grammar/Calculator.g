grammar Calculator;
 
options {
    language=CSharp3;
}

public stat:statement_list;

statement_list: (statement)*;

public statement: expr_statement
    |print_statement
    ;

public print_statement: PRINT expr ';';
public expr_statement: expr ';';
public expr: addexpr;

public addexpr: mulexpr ('+'|'-' mulexpr)*;

public mulexpr:term ('*'|'/' term)*;

term: INT |'(' expr ')';
/*
Lexer rules
*/

INT:'0'..'9'+;
WS:(' '|'\t'|'\r'|'\n'){Skip();};
PRINT: 'print';
