#ifndef COMPI_HW3_SYMBOLTABLE_H
#define COMPI_HW3_SYMBOLTABLE_H

#include "nodes.hpp"
#include <vector>
#include <string>
#include <iostream>

using namespace std;

class Symbol {
public:
    string name;
    ast::BuiltInType type;
    int offset;
    //now only for functions
    bool isFunction;
    vector<ast::BuiltInType> paramTypes;
    ast::BuiltInType retType;

    //regular symbol c'tor
    Symbol(string n, ast::BuiltInType t, int off)
            : name(n), type(t), offset(off), isFunction(false), retType(ast::BuiltInType::VOID) {}

    //function symbol c'tor
    Symbol(string n, ast::BuiltInType ret, vector<ast::BuiltInType> params)
            : name(n), type(ret), offset(0), isFunction(true), paramTypes(params), retType(ret) {}
};

class SymbolTable {
    //tables stack, a stack where each var is a vector of symbols
    vector<vector<Symbol>> tables;

    //offset stack
    vector<int> offsets;

public:
    //need to open main null scope
    SymbolTable();

    //create new empty scope
    void pushScope();

    //create new empty scope for func entrance
    void pushFunctionScope();

    //close scope
    void popScope();

    //add new var to current scope
    void insertVar(const string& name, ast::BuiltInType type);

    //enter vars of func, need negative offset
    void insertFuncArg(const string& name, ast::BuiltInType type, int offset);

    //enter a func var
    void insertFunc(const string& name, ast::BuiltInType retType, vector<ast::BuiltInType> paramTypes);

    //find a symbol in the table
    Symbol* getSymbol(const string& name);
};

#endif //COMPI_HW3_SYMBOLTABLE_H
