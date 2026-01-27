%{

/* Declarations section */
#include <stdio.h>
#include <memory>
#include "output.hpp"
#include "parser.tab.h"
#include <string>

void make_op(int enum_val) {
    std::string val = std::to_string(enum_val);
    yylval = std::make_shared<ast::Num>(val.c_str());
}

%}

%option yylineno
%option noyywrap

%%

[ \n\t\r]+       {} /* Ignore whitespaces */

void    return VOID;
int     return INT;
byte    return BYTE;
bool    return BOOL;
and     return AND;
or      return OR;
not     return NOT;
true    return TRUE;
false   return FALSE;
return  return RETURN;
if      return IF;
else    return ELSE;
while   return WHILE;
break   return BREAK;
continue    return CONTINUE;
;   return SC;
,   return COMMA;
\(   return LPAREN;
\)   return RPAREN;
\{   return LBRACE;
\}   return RBRACE;
\[   return LBRACK;
\]   return RBRACK;
\=   return ASSIGN;

"+"   { make_op(ast::ADD); return BINOP; }
"-"   { make_op(ast::SUB); return BINOP; }
"*"   { make_op(ast::MUL); return BINOP; }
"/"   { make_op(ast::DIV); return BINOP; }

"=="  { make_op(ast::EQ); return RELOP; }
"!="  { make_op(ast::NE); return RELOP; }
"<"   { make_op(ast::LT); return RELOP; }
">"   { make_op(ast::GT); return RELOP; }
"<="  { make_op(ast::LE); return RELOP; }
">="  { make_op(ast::GE); return RELOP; }


\/\/.* ;

[a-zA-Z][a-zA-Z0-9]* {
    yylval = std::make_shared<ast::ID>(yytext);
    return ID;
}

[1-9][0-9]* {
    yylval = std::make_shared<ast::Num>(yytext);
    return NUM;
}
0 {
    yylval = std::make_shared<ast::Num>(yytext);
    return NUM;
}
[1-9][0-9]*b {
    yylval = std::make_shared<ast::NumB>(yytext);
    return NUM_B;
};
0b {
    yylval = std::make_shared<ast::NumB>(yytext);
    return NUM_B;
};

\"([^\n\r\"\\]|\\[rnt"\\])+\" {
    yylval = std::make_shared<ast::String>(yytext);
    return STRING;
};

. {
    output::errorLex(yylineno);
    exit(0);
};

%%