#ifndef OUTPUT_HPP
#define OUTPUT_HPP

#include <vector>
#include <string>
#include <sstream>
#include <stack>
#include <iostream>
#include "visitor.hpp"
#include "nodes.hpp"

namespace output {

    void errorLex(int lineno);
    void errorSyn(int lineno);
    void errorUndef(int lineno, const std::string &id);
    void errorDefAsFunc(int lineno, const std::string &id);
    void errorUndefFunc(int lineno, const std::string &id);
    void errorDefAsVar(int lineno, const std::string &id);
    void errorDef(int lineno, const std::string &id);
    void errorPrototypeMismatch(int lineno, const std::string &id, std::vector<std::string> &paramTypes);
    void errorMismatch(int lineno);
    void errorUnexpectedBreak(int lineno);
    void errorUnexpectedContinue(int lineno);
    void errorMainMissing();
    void errorByteTooLarge(int lineno, int value);
    void errorDivByZero(int lineno);

    class CodeBuffer {
    private:
        std::stringstream globalsBuffer;
        std::stringstream buffer;
        int labelCount;
        int varCount;
        int stringCount;

        friend std::ostream &operator<<(std::ostream &os, const CodeBuffer &buffer);

    public:
        CodeBuffer();
        std::string freshLabel();
        std::string freshVar();
        void emitLabel(const std::string &label);
        std::string emitString(const std::string &str);
        void emit(const std::string &str);
        void emitGlobal(const std::string &str);

        template<typename T>
        CodeBuffer &operator<<(const T &value) {
            buffer << value;
            return *this;
        }
        
        std::stringstream& getGlobalsBuffer() { return globalsBuffer; }
    };

    std::ostream &operator<<(std::ostream &os, const CodeBuffer &buffer);

    class Symbol {
    public:
        std::string name;
        ast::BuiltInType type;
        int offset;
        bool isFunction;
        std::vector<ast::BuiltInType> paramTypes;
        ast::BuiltInType retType;
        
        std::string llvmVar;

        Symbol(std::string n, ast::BuiltInType t, int off, std::string llvmName = "")
            : name(n), type(t), offset(off), isFunction(false), retType(ast::BuiltInType::VOID), llvmVar(llvmName) {}

        Symbol(std::string n, ast::BuiltInType ret, std::vector<ast::BuiltInType> params)
            : name(n), type(ret), offset(0), isFunction(true), paramTypes(params), retType(ret), llvmVar("") {}
    };

    class SymbolTable {
        std::vector<std::vector<Symbol>> tables;
        std::vector<int> offsets;

    public:
        SymbolTable();
        void pushScope();
        void popScope();
        void insertVar(const std::string &name, ast::BuiltInType type, std::string llvmVar);
        void insertFunc(const std::string &name, ast::BuiltInType retType, std::vector<ast::BuiltInType> paramTypes);
        Symbol* getSymbol(const std::string &name);
        bool contains(const std::string &name);
    };

    class SemanticVisitor : public Visitor {
    private:
        SymbolTable symbolTable;
        CodeBuffer buffer;
        
        std::stack<std::string> loopContinueLabels;
        std::stack<std::string> loopBreakLabels;
        std::string currentFuncEndLabel;
        ast::BuiltInType currentFuncRetType;
        
        std::string lastReg;

        ast::BuiltInType last_type;
        bool blockTerminated = false;

        std::string getTypeStr(ast::BuiltInType type);
        std::string getZeroValue(ast::BuiltInType type);
        void emitPrintFunctions();
        void emitCast(const std::string& reg, ast::BuiltInType fromType, ast::BuiltInType toType); // Add this line

    public:
        SemanticVisitor();
        
        void print_buf();

        void visit(ast::Num &node) override;
        void visit(ast::NumB &node) override;
        void visit(ast::String &node) override;
        void visit(ast::Bool &node) override;
        void visit(ast::ID &node) override;
        void visit(ast::BinOp &node) override;
        void visit(ast::RelOp &node) override;
        void visit(ast::Not &node) override;
        void visit(ast::And &node) override;
        void visit(ast::Or &node) override;
        void visit(ast::Type &node) override;
        void visit(ast::Cast &node) override;
        void visit(ast::ExpList &node) override;
        void visit(ast::Call &node) override;
        void visit(ast::Statements &node) override;
        void visit(ast::Break &node) override;
        void visit(ast::Continue &node) override;
        void visit(ast::Return &node) override;
        void visit(ast::If &node) override;
        void visit(ast::While &node) override;
        void visit(ast::VarDecl &node) override;
        void visit(ast::Assign &node) override;
        void visit(ast::Formal &node) override;
        void visit(ast::Formals &node) override;
        void visit(ast::FuncDecl &node) override;
        void visit(ast::Funcs &node) override;
    };
}

#endif //OUTPUT_HPP