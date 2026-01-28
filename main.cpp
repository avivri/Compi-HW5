#include <iostream>
#include "output.hpp"
#include "nodes.hpp"

extern int yyparse();
extern std::shared_ptr<ast::Node> program;

int main() {
    // Parse the input. The result is stored in the global variable `program`
    yyparse();

    // Print the AST using the PrintVisitor
    output::MyVisitor visitor;
    program->accept(visitor);

    visitor.print_buf();
}