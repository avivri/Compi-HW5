%{
#include "nodes.hpp"
#include "output.hpp"
#include <iostream>

// bison declarations
extern int yylineno;
extern int yylex();

void yyerror(const char*);
std::shared_ptr<ast::Node> program;
using namespace std;
%}

%token VOID INT BYTE B BOOL CONST TRUE FALSE RETURN IF ELSE WHILE BREAK CONTINUE SC COMMA LBRACE RBRACE LBRACK RBRACK ASSIGN RELOP BINOP COMMENT ID NUM NUM_B STRING

%right ASSIGN
%left OR
%left AND
%left RELOP
%left BINOP
%right NOT
%left LBRACK RBRACK
%left LPAREN RPAREN

%nonassoc LOWER_THAN_ELSE //dummy for ELSE s/r conflict
%nonassoc ELSE

%%

Program:  Funcs { program = $1; }
;

Funcs: /* eps */ {$$ = std::make_shared<ast::Funcs>();}
    | FuncDecl Funcs { auto list = std::dynamic_pointer_cast<ast::Funcs>($2);
                       auto func = std::dynamic_pointer_cast<ast::FuncDecl>($1);
                       list->push_front(func);

                       $$ = list;
                   }
    ;

FuncDecl:  RetType ID LPAREN Formals RPAREN LBRACE Statements RBRACE {
                auto id = std::dynamic_pointer_cast<ast::ID>($2);
                auto retType = std::dynamic_pointer_cast<ast::Type>($1);
                auto formals = std::dynamic_pointer_cast<ast::Formals>($4);
                auto statements = std::dynamic_pointer_cast<ast::Statements>($7);

                $$ = std::make_shared<ast::FuncDecl>(id, retType, formals, statements);
            }

RetType: Type { $$ = $1; }
    | VOID { $$ = std::make_shared<ast::Type>(ast::BuiltInType::VOID); }
    ;

Formals: /* eps */ {$$ = std::make_shared<ast::Formals>();}
    | FormalsList { $$ = $1; }
    ;

FormalsList: FormalDecl {
                $$ = std::make_shared<ast::Formals>(std::dynamic_pointer_cast<ast::Formal>($1));
             }
    | FormalDecl COMMA FormalsList { auto formals = std::dynamic_pointer_cast<ast::Formals>($3);
                                    auto formal = std::dynamic_pointer_cast<ast::Formal>($1);
                                    formals->push_front(formal);

                                    $$ = formals;
                                }
    ;

FormalDecl: Type ID { auto type = std::dynamic_pointer_cast<ast::Type>($1);
                      auto id = std::dynamic_pointer_cast<ast::ID>($2);

                      $$ = std::make_shared<ast::Formal>(id, type);
                  }
    ;

Statements: Statement {
                auto statement = std::dynamic_pointer_cast<ast::Statement>($1);
                $$ = std::make_shared<ast::Statements>(statement);
            }
    | Statements Statement {
        auto list = std::dynamic_pointer_cast<ast::Statements>($1);
        auto statement = std::dynamic_pointer_cast<ast::Statement>($2);
        list->push_back(statement);

        $$ = list;
    }
    ;

Statement: LBRACE Statements RBRACE {
        $$ = $2;
    }
    | Type ID SC {
        auto type = std::dynamic_pointer_cast<ast::Type>($1);
        auto id = std::dynamic_pointer_cast<ast::ID>($2);

        $$ = std::make_shared<ast::VarDecl>(id, type);
    }
    | Type ID ASSIGN Exp SC {
        auto type = std::dynamic_pointer_cast<ast::Type>($1);
        auto id = std::dynamic_pointer_cast<ast::ID>($2);
        auto exp = std::dynamic_pointer_cast<ast::Exp>($4);

        $$ = std::make_shared<ast::VarDecl>(id, type, exp);
    }
    | ID ASSIGN Exp SC {
        auto id = std::dynamic_pointer_cast<ast::ID>($1);
        auto exp = std::dynamic_pointer_cast<ast::Exp>($3);

        $$ = std::make_shared<ast::Assign>(id, exp);
    }
    | Call SC {
        auto call = std::dynamic_pointer_cast<ast::Call>($1);

        $$ = call;
    }
    | RETURN SC {
        $$ = std::make_shared<ast::Return>();
    }
    | RETURN Exp SC {
        auto exp = std::dynamic_pointer_cast<ast::Exp>($2);

        $$ = std::make_shared<ast::Return>(exp);
    }
    | IF LPAREN Exp RPAREN Statement %prec LOWER_THAN_ELSE {
        auto exp = std::dynamic_pointer_cast<ast::Exp>($3);
        auto statement = std::dynamic_pointer_cast<ast::Statement>($5);

        $$ = std::make_shared<ast::If>(exp, statement);
    }
    | IF LPAREN Exp RPAREN Statement ELSE Statement {
        auto exp = std::dynamic_pointer_cast<ast::Exp>($3);
        auto thenStatement = std::dynamic_pointer_cast<ast::Statement>($5);
        auto elseStatement = std::dynamic_pointer_cast<ast::Statement>($7);

        $$ = std::make_shared<ast::If>(exp, thenStatement, elseStatement);
    }
    | WHILE LPAREN Exp RPAREN Statement {
        auto exp = std::dynamic_pointer_cast<ast::Exp>($3);
        auto statement = std::dynamic_pointer_cast<ast::Statement>($5);

        $$ = std::make_shared<ast::While>(exp, statement);
    }
    | BREAK SC {
        $$ = std::make_shared<ast::Break>();
    }
    | CONTINUE SC {
        $$ = std::make_shared<ast::Continue>();
    }
    ;

Call: ID LPAREN ExpList RPAREN {
         auto id = std::dynamic_pointer_cast<ast::ID>($1);
         auto expList = std::dynamic_pointer_cast<ast::ExpList>($3);

         $$ = std::make_shared<ast::Call>(id, expList);
     }
    | ID LPAREN RPAREN {
         auto id = std::dynamic_pointer_cast<ast::ID>($1);
         auto expList = std::make_shared<ast::ExpList>();

         $$ = std::make_shared<ast::Call>(id, expList);
    }
    ;

ExpList: Exp {
         auto exp = std::dynamic_pointer_cast<ast::Exp>($1);
         auto expList = std::make_shared<ast::ExpList>(exp);

         $$ = expList;
     }
    | Exp COMMA ExpList {
         auto exp = std::dynamic_pointer_cast<ast::Exp>($1);
         auto expList = std::dynamic_pointer_cast<ast::ExpList>($3);
         expList->push_front(exp);

         $$ = expList;
     }
    ;

Type: INT {
       $$ = std::make_shared<ast::Type>(ast::BuiltInType::INT);
    }
    | BYTE {
       $$ = std::make_shared<ast::Type>(ast::BuiltInType::BYTE);
    }
    | BOOL {
       $$ = std::make_shared<ast::Type>(ast::BuiltInType::BOOL);
    }
    ;

Exp: LPAREN Exp RPAREN {$$ = $2;}
    | Exp BINOP Exp { auto left = std::dynamic_pointer_cast<ast::Exp>($1);
        auto right = std::dynamic_pointer_cast<ast::Exp>($3);
        
        auto numNode = std::dynamic_pointer_cast<ast::Num>($2);
    

        ast::BinOpType op = static_cast<ast::BinOpType>(numNode->value);

        $$ = std::make_shared<ast::BinOp>(left, right, op);}
    | ID {$$ = $1;}
    | Call {
        $$ = $1;
    }
    | NUM {$$ = $1;}
    | NUM_B {$$ = $1;}
    | STRING {$$ = $1;}
    | TRUE {$$ = std::make_shared<ast::Bool>(true);}
    | FALSE {$$ = std::make_shared<ast::Bool>(false);}
    | NOT Exp { auto exp = std::dynamic_pointer_cast<ast::Exp>($2);
        $$ = std::make_shared<ast::Not>(exp);}
    | Exp AND Exp {auto left = std::dynamic_pointer_cast<ast::Exp>($1);
        auto right = std::dynamic_pointer_cast<ast::Exp>($3);
        $$ = std::make_shared<ast::And>(left, right);}
    | Exp OR Exp {auto left = std::dynamic_pointer_cast<ast::Exp>($1);
        auto right = std::dynamic_pointer_cast<ast::Exp>($3);
        $$ = std::make_shared<ast::Or>(left, right);}
    | Exp RELOP Exp { auto left = std::dynamic_pointer_cast<ast::Exp>($1);
        auto right = std::dynamic_pointer_cast<ast::Exp>($3);
        
        auto numNode = std::dynamic_pointer_cast<ast::Num>($2);
    

        ast::RelOpType op = static_cast<ast::RelOpType>(numNode->value);

        $$ = std::make_shared<ast::RelOp>(left, right, op);}
    | LPAREN Type RPAREN Exp {auto type = std::dynamic_pointer_cast<ast::Type>($2);
        auto exp = std::dynamic_pointer_cast<ast::Exp>($4);
        $$ = std::make_shared<ast::Cast>(exp, type);
    }
    ;

%%

void yyerror(const char* s) {
    output::errorSyn(yylineno);
    exit(0);
}