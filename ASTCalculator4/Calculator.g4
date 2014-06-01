grammar Calculator;
 
tokens {
FOR_INIT,FOR_CONDITION,FOR_ITER,
ARRAY_DECLARATOR,VARIABLE_DEF,TYPE,MODIFIERS,
VAR_INIT,STATEMENT_LIST,INDEX_OP,
}
@lexer::namespace{Calculator}
@parser::namespace{Calculator}
@parser::members{
}
@header {
using System;
}

stat:statement_list;

statement_list
: statement*  
;

statement: exprStatement
    | printStatement
    | declarationStatement
    | ifStatement
    | compoudStartment
    | forStatement
    | emptyStatement
    ;

emptyStatement: SEMI;
ifStatement: IF LPAREN expr RPAREN statement
(
    ELSE statement
)?;

compoudStartment
    : LCURLY statement* RCURLY
    ;

declarationStatement: declaration SEMI;
printStatement: PRINT expr SEMI;
exprStatement: expr SEMI;
forStatement: FOR LPAREN forInit SEMI forCond SEMI forIter RPAREN statement;

forInit: (declaration|exprList)?
;
forCond: (a=expr)?
;

forIter
    : (a=exprList)?
    ;


declaration
    : m=modifiers t=typeSpec v=varDeclarations
    ;
modifiers: MODIFIER*;
varDeclarations: varDeclaration (COMMA varDeclaration)*;

varDeclaration
    : ID declareBrackets v=varInitializer
;

declareBrackets
    : (LBRACK expr RBRACK)*
   ;

varInitializer
    : (ASSIGN initializer)?;
initializer: expr;
typeSpec: BUILTIN_TYPE;


exprList: expr (COMMA expr)*;
expr : a=assign_expr;

assign_expr: borexpr (ASSIGN assign_expr)?;

borexpr : a=bxorexpr  (BOR b=bxorexpr)*;
bxorexpr : a=bandexpr  (BXOR b=bandexpr)*;
bandexpr : a=eqexpr  (BAND b=eqexpr)*;
eqexpr: relationexpr ((EQ|NE) relationexpr)*;
relationexpr: shiftexpr ((LT
|GT
|LE
|GE)
shiftexpr)*;

shiftexpr : a=addexpr  (LSHIFT b=addexpr|RSHIFT b=addexpr)*;
addexpr : mulexpr (PLUS mulexpr|MINUS mulexpr)*;

mulexpr :a=unaryExpr (MUL unaryExpr|DIV unaryExpr|MOD unaryExpr)*;

unaryExpr:INC postfixExpr
| DEC postfixExpr
| postfixExpr
;

postfixExpr: 
indexExpr (INC|DEC)?
;


indexExpr
: term (LBRACK expr RBRACK) *
;
// why below doesn't work 
// term INC
// | term DEC
// | term

term  : a= constant 
    |'(' expr ')'
    |func_expr
    |ID
;

func_expr :
    POW '(' a=expr ',' b=expr')';

constant: NUM_INT 
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
ID: ('a'..'z'|'A'..'Z'|'_')('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;

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
COMMENT: '//' ~ ('\r'|'\n')*;
