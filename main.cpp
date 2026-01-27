#include <iostream>
#include "output.hpp"
#include "nodes.hpp"

// Extern from the bison-generated parser
extern int yyparse();
extern std::shared_ptr<ast::Node> program;

int main() {
    // 1. Parse the input (constructs the AST using your nodes)
    // Returns 0 on success
    int parse_result = yyparse();
    
    if (parse_result != 0) {
        // Parse error (lex/syn) handling is done inside yyparse/yyerror
        return 0; 
    }

    if (program) {
        // 2. Create the Code Generation Visitor
        output::MyVisitor visitor;

        // 3. Traverse the AST
        try {
            program->accept(visitor);
        } catch (const std::exception& e) {
            std::cerr << "Error during code generation: " << e.what() << std::endl;
            return 1;
        }

        // 4. Print the final LLVM buffer to stdout
        visitor.print_buf();
    }

    return 0;
}