grammar Calculator;
 
options {
    language=CSharp3;
    TokenLabelType=CommonToken;
    output=AST;
    ASTLabelType=CommonTree;
}
@lexer::namespace{Calculator}
@parser::namespace{Calculator}
@parser::members{
}
@header {
using System;
}

public stat:statement_list;

statement_list: statement*;

public statement: exprStatement
    | printStatement
    | declarationStatement
    | ifStatement
    | compoudStartment
    | forStatement
    | emptyStatement
    ;

public emptyStatement: SEMI;
public ifStatement: IF^ LPAREN expr RPAREN statement
(
    ELSE statement
)?;

public compoudStartment: LCURLY^ statement* RCURLY;

public declarationStatement: declaration SEMI!;
public printStatement: PRINT a=expr SEMI!;
public exprStatement: expr SEMI!;
public forStatement: FOR LPAREN forInit SEMI forCond SEMI forInit RPAREN statement;

public forInit: (declaration|exprList)?;
public forCond: (expr)?;
public forIterList: (exprList)?;


public declaration: modifiers typeSpec^ varDeclarations;
public modifiers: MODIFIER*;
public varDeclarations: varDeclaration (COMMA varDeclaration)*;
public varDeclaration: ID declareBrackets varInitializer;
public declareBrackets: (LBRACK expr RBRACK)*;
public varInitializer: (ASSIGN^ initializer)?;
public initializer: expr;
public typeSpec: BUILTIN_TYPE;


public exprList: expr (COMMA expr)*;
public expr : a=assign_expr;

public assign_expr: borexpr (ASSIGN^ assign_expr)?;

public borexpr : a=bxorexpr  (BOR^ b=bxorexpr)*;
public bxorexpr : a=bandexpr  (BXOR^ b=bandexpr)*;
public bandexpr : a=eqexpr  (BAND^ b=eqexpr)*;
public eqexpr: relationexpr ((EQ^|NE^) relationexpr)*;
public relationexpr: shiftexpr ((LT^
|GT^
|LE^
|GE^)
shiftexpr)*;

public shiftexpr : a=addexpr  (LSHIFT^ b=addexpr|RSHIFT^ b=addexpr)*;
public addexpr : a=mulexpr (PLUS^ b=mulexpr|MINUS^ b= mulexpr)*;

public mulexpr :a=unaryExpr (MUL^ b=unaryExpr|DIV^ unaryExpr|MOD^ b=unaryExpr)*;

public unaryExpr:INC postfixExpr
| DEC postfixExpr
| postfixExpr
;

public postfixExpr: term(
(LBRACK expr RBRACK)*
)
 (INC|DEC|);
// why below doesn't work 
// term INC
// | term DEC
// | term

public term  : a= constant 
    |'('! expr ')'!
    |func_expr
    |ID
;

public func_expr :
    POW '('^ a=expr ',' b=expr')';

public constant: NUM_INT 
| CHAR_LITERAL
| STRING_LTERRAL;

/*
Lexer rules
*/


BUILTIN_TYPE:
'int'
| 'double'
| 'float'
| 'bool'
| 'char'
;


IF: 'if';
ELSE: 'else';
WHILE: 'while';
DO: 'do';
FOR: 'for';
MODIFIER: 'static'
| 'const'
;
EQ: '==';
NE: '!=';
PLUS_ASSIGN: '+=';
MINUS_ASSIGN: '-=';
MUL_ASSIGN: '*=';
DIV_ASSIGN: '/=';
MOD_ASSIGN: '%=';
NUM_INT:'0'..'9'+;

LSHIFT: '<<';
RSHIFT: '>>';
INC: '++';
DEC: '--';

GE: '>=';
LE: '<=';
GT: '>';
LT: '<';
ASSIGN: '=';
BOR: '|';
BAND:'&';
BXOR:'^';
SEMI:';';

LCURLY: '{';
RCURLY: '}';
LBRACK: '[';
RBRACK: ']';
LPAREN: '(';
RPAREN: ')';
MOD : '%';
MUL:'*';
DIV:'/';
PLUS:'+';
MINUS:'-';
COMMA: ',';
WS:(' '|'\t'|'\r'|'\n'){Skip();};
PRINT: 'print';
POW: 'pow';
ID: ('a'..'z'|'A'..'Z')+;

CHAR_LITERAL: '\'' (ESC|~'\'') '\'';
STRING_LTERRAL: '"' (ESC|~('"'|'\\'))*'"';

ESC: '\\'
('n'
| 'r'
| 't'
| 'b'
| 'f'
| '"'
| '\''
| '\\'
);
