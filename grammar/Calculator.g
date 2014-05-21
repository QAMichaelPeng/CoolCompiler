grammar Calculator;
 
options {
    language=CSharp3;
}
@lexer::namespace{Calculator}
@parser::namespace{Calculator}
@header {
using System;
}

public stat:statement_list;

statement_list: (statement)*;

public statement: expr_statement
    |print_statement
    ;

public print_statement: PRINT a=expr ';'{Console.WriteLine(a);};
public expr_statement: expr ';';
public expr returns[int value]: a=addexpr{$value=a;};

public addexpr returns[int value]: a=mulexpr{$value=a;} ('+' b=mulexpr{$value+=b;}|'-' b= mulexpr{$value-=b;})*;

public mulexpr returns [int value]:a=term{$value = a;} ('*' b=term{$value*=b;}|'/' term{$value/=b;})*;

term returns[int value] : a=INT {$value=int.Parse($a.text);} |'('b=expr ')'{$value=b;};
/*
Lexer rules
*/

INT:'0'..'9'+;
WS:(' '|'\t'|'\r'|'\n'){Skip();};
PRINT: 'print';
