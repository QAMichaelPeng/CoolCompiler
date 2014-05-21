grammar Calculator;
 
options {
    language=CSharp3;
}
@lexer::namespace{Calculator}
@parser::namespace{Calculator}
@parser::members{
    public bool Debug{get;set;}
}
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
public expr returns[int value]: a=borexpr{$value=a;};

public func_expr returns[int value]:
    'pow' '(' a=expr ',' b=expr{$value=(int)Math.Pow(a, b);}')';

public borexpr returns [int value]: a=bxorexpr {$value=a;} ('|' b=bxorexpr{$value|=b;})*;
public bxorexpr returns [int value]: a=bandexpr {$value=a;} ('^' b=bandexpr{$value^=b;})*;
public bandexpr returns [int value]: a=shiftexpr {$value=a;} ('&' b=shiftexpr{$value&=b;})*;
public shiftexpr returns [int value]: a=addexpr {$value=a;} ('<<' b=addexpr{$value<<=b;}|'>>' b=addexpr{$value>>=b;})*;
public addexpr returns[int value]: a=mulexpr{$value=a;} ('+' b=mulexpr{$value+=b;}|'-' b= mulexpr{$value-=b;})*;

public mulexpr returns [int value]:a=term{$value = a;} (MUL b=term{$value*=b;}|DIV term{$value/=b;}|MOD b=term{$value=$value \% b;})*;

term returns[int value] : a=INT {$value=int.Parse($a.text);} 
    |'('b=expr ')'{$value=b;}
    |b=func_expr{$value=b;};
/*
Lexer rules
*/

INT:'0'..'9'+;
MOD : '%';
MUL:'*';
DIV:'/';
WS:(' '|'\t'|'\r'|'\n'){Skip();};
PRINT: 'print';
