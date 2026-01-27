#include "symbolTable.h"

SymbolTable::SymbolTable() {
    //global main null scope
    pushScope();
}

void SymbolTable::pushScope() {
    vector<Symbol> newScope;
    tables.push_back(newScope);

    if(offsets.empty())
        offsets.push_back(0);
    else
        offsets.push_back(offsets.back());
}

void SymbolTable::pushFunctionScope() {
    vector<Symbol> newScope;
    tables.push_back(newScope);
    offsets.push_back(0); //local vars of function defined in 0 offset
}

void SymbolTable::popScope() {
    if (!tables.empty()) {
        tables.pop_back();
        offsets.pop_back();
    }
}

void SymbolTable::insertVar(const string& name, ast::BuiltInType type) {
    int currentOffset = offsets.back();

    Symbol newSym = Symbol(name, type, currentOffset);
    tables.back().push_back(newSym);

    offsets.back()++;
}

void SymbolTable::insertFuncArg(const string& name, ast::BuiltInType type, int offset) {
    Symbol newSym = Symbol(name, type, offset);
    tables.back().push_back(newSym);
}

void SymbolTable::insertFunc(const string& name, ast::BuiltInType retType, vector<ast::BuiltInType> paramTypes) {
    Symbol newFuncSym = Symbol(name, retType, paramTypes);
    tables.back().push_back(newFuncSym); //enter to the global scope
}

Symbol* SymbolTable::getSymbol(const string& name) {
    for (int i = tables.size() - 1; i >= 0; --i) {
        for (auto& sym : tables[i]) {
            if (sym.name == name) {
                return &sym;
            }
        }
    }
    return nullptr;
}
