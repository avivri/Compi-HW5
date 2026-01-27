#include "output.hpp"
#include <iostream>
#include <stdexcept>

extern int yylineno;

namespace output {

    // --- Error Handling Implementations ---
    void errorLex(int lineno) {
        std::cout << "line " << lineno << ": lexical error" << std::endl;
        exit(0);
    }

    void errorSyn(int lineno) {
        std::cout << "line " << lineno << ": syntax error" << std::endl;
        exit(0);
    }

    void errorUndef(int lineno, const std::string &id) {
        std::cout << "line " << lineno << ": variable " << id << " is not defined" << std::endl;
        exit(0);
    }

    void errorDefAsFunc(int lineno, const std::string &id) {
        std::cout << "line " << lineno << ": symbol " << id << " is a function" << std::endl;
        exit(0);
    }

    void errorUndefFunc(int lineno, const std::string &id) {
        std::cout << "line " << lineno << ": function " << id << " is not defined" << std::endl;
        exit(0);
    }

    void errorDefAsVar(int lineno, const std::string &id) {
        std::cout << "line " << lineno << ": symbol " << id << " is a variable" << std::endl;
        exit(0);
    }

    void errorDef(int lineno, const std::string &id) {
        std::cout << "line " << lineno << ": symbol " << id << " is already defined" << std::endl;
        exit(0);
    }

    void errorPrototypeMismatch(int lineno, const std::string &id, std::vector<std::string> &paramTypes) {
        std::cout << "line " << lineno << ": prototype mismatch, function " << id << " expects arguments (";
        for (size_t i = 0; i < paramTypes.size(); ++i) {
            std::cout << paramTypes[i];
            if (i != paramTypes.size() - 1) std::cout << ",";
        }
        std::cout << ")" << std::endl;
        exit(0);
    }

    void errorMismatch(int lineno) {
        std::cout << "line " << lineno << ": type mismatch" << std::endl;
        exit(0);
    }

    void errorUnexpectedBreak(int lineno) {
        std::cout << "line " << lineno << ": unexpected break statement" << std::endl;
        exit(0);
    }

    void errorUnexpectedContinue(int lineno) {
        std::cout << "line " << lineno << ": unexpected continue statement" << std::endl;
        exit(0);
    }

    void errorMainMissing() {
        std::cout << "Program has no 'main' function" << std::endl;
        exit(0);
    }

    void errorByteTooLarge(int lineno, int value) {
        std::cout << "line " << lineno << ": byte value " << value << " out of range" << std::endl;
        exit(0);
    }

    void errorDivByZero(int lineno) {
        std::cout << "line " << lineno << ": division by zero" << std::endl;
        exit(0);
    }

    // --- CodeBuffer Implementation ---
    CodeBuffer::CodeBuffer() : labelCount(0), varCount(0), stringCount(0) {}

    std::string CodeBuffer::freshLabel() {
        return "label_" + std::to_string(++labelCount);
    }

    std::string CodeBuffer::freshVar() {
        return "%t" + std::to_string(++varCount);
    }

    void CodeBuffer::emitLabel(const std::string &label) {
        buffer << label << ":" << std::endl;
    }

    std::string CodeBuffer::emitString(const std::string &str) {
        std::string var = "@.str" + std::to_string(++stringCount);
        int len = str.length() + 1;
        globalsBuffer << var << " = constant [" << len << " x i8] c\"" << str << "\\00\"" << std::endl;
        return var;
    }

    void CodeBuffer::emit(const std::string &str) {
        buffer << "  " << str << std::endl;
    }

    void CodeBuffer::emitGlobal(const std::string &str) {
        globalsBuffer << str << std::endl;
    }

    std::ostream &operator<<(std::ostream &os, const CodeBuffer &buffer) {
        os << buffer.globalsBuffer.str() << std::endl << buffer.buffer.str();
        return os;
    }

    // --- SymbolTable Implementation ---
    SymbolTable::SymbolTable() {
        pushScope();
        std::vector<ast::BuiltInType> printTypes = {ast::BuiltInType::STRING};
        insertFunc("print", ast::BuiltInType::VOID, printTypes);
        std::vector<ast::BuiltInType> printiTypes = {ast::BuiltInType::INT};
        insertFunc("printi", ast::BuiltInType::VOID, printiTypes);
    }

    void SymbolTable::pushScope() {
        tables.push_back(std::vector<Symbol>());
        offsets.push_back(offsets.empty() ? 0 : offsets.back());
    }

    void SymbolTable::popScope() {
        if (!tables.empty()) {
            tables.pop_back();
            offsets.pop_back();
        }
    }

    void SymbolTable::insertVar(const std::string &name, ast::BuiltInType type, std::string llvmVar) {
        int currentOffset = offsets.back();
        Symbol newSym(name, type, currentOffset, llvmVar);
        tables.back().push_back(newSym);
        offsets.back()++;
    }

    void SymbolTable::insertFunc(const std::string &name, ast::BuiltInType retType, std::vector<ast::BuiltInType> paramTypes) {
        Symbol newSym(name, retType, paramTypes);
        tables.back().push_back(newSym);
    }

    Symbol* SymbolTable::getSymbol(const std::string &name) {
        for (int i = tables.size() - 1; i >= 0; --i) {
            for (auto &sym : tables[i]) {
                if (sym.name == name) return &sym;
            }
        }
        return nullptr;
    }

    bool SymbolTable::contains(const std::string &name) {
        return getSymbol(name) != nullptr;
    }

    // --- MyVisitor Implementation ---

    MyVisitor::MyVisitor() : blockTerminated(false) {
        buffer.emitGlobal("declare i32 @printf(i8*, ...)");
        buffer.emitGlobal("declare void @exit(i32)");
        emitPrintFunctions();
    }

    void MyVisitor::print_buf() {
        std::cout << buffer;
    }

    std::string MyVisitor::getTypeStr(ast::BuiltInType type) {
        switch (type) {
            case ast::BuiltInType::INT: return "i32";
            case ast::BuiltInType::BYTE: return "i8";
            case ast::BuiltInType::BOOL: return "i1";
            case ast::BuiltInType::VOID: return "void";
            case ast::BuiltInType::STRING: return "i8*";
            default: return "i32";
        }
    }

    std::string MyVisitor::getZeroValue(ast::BuiltInType type) {
        return "0";
    }

    void MyVisitor::emitPrintFunctions() {
        buffer.emitGlobal("@.int_specifier = constant [4 x i8] c\"%d\\0A\\00\"");
        buffer.emitGlobal("@.str_specifier = constant [4 x i8] c\"%s\\0A\\00\"");

        buffer.emitGlobal("define void @printi(i32) {");
        buffer.emitGlobal("  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.int_specifier, i32 0, i32 0");
        buffer.emitGlobal("  call i32 (i8*, ...) @printf(i8* %spec_ptr, i32 %0)");
        buffer.emitGlobal("  ret void");
        buffer.emitGlobal("}");

        buffer.emitGlobal("define void @print(i8*) {");
        buffer.emitGlobal("  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.str_specifier, i32 0, i32 0");
        buffer.emitGlobal("  call i32 (i8*, ...) @printf(i8* %spec_ptr, i8* %0)");
        buffer.emitGlobal("  ret void");
        buffer.emitGlobal("}");
    }

    // Helper to emit implicit cast if needed
    void MyVisitor::emitCast(const std::string& reg, ast::BuiltInType fromType, ast::BuiltInType toType) {
        if (fromType == toType) return;

        if (fromType == ast::BuiltInType::BYTE && toType == ast::BuiltInType::INT) {
            std::string newReg = buffer.freshVar();
            buffer.emit(newReg + " = zext i8 " + reg + " to i32");
            lastReg = newReg;
            last_type = ast::BuiltInType::INT;
        } else if (fromType == ast::BuiltInType::INT && toType == ast::BuiltInType::BYTE) {
            std::string newReg = buffer.freshVar();
            buffer.emit(newReg + " = trunc i32 " + reg + " to i8");
            lastReg = newReg;
            last_type = ast::BuiltInType::BYTE;
        }
    }

    void MyVisitor::visit(ast::Num &node) {
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::INT;
        buffer.emit(lastReg + " = add i32 " + std::to_string(node.value) + ", 0");
    }

    void MyVisitor::visit(ast::NumB &node) {
        if (node.value > 255) errorByteTooLarge(node.line, node.value);
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::BYTE;
        buffer.emit(lastReg + " = add i8 " + std::to_string(node.value) + ", 0");
    }

    void MyVisitor::visit(ast::String &node) {
        std::string globalVar = buffer.emitString(node.value);
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::STRING;
        buffer.emit(lastReg + " = getelementptr [" + std::to_string(node.value.length() + 1) + " x i8], ["
                    + std::to_string(node.value.length() + 1) + " x i8]* " + globalVar + ", i32 0, i32 0");
    }

    void MyVisitor::visit(ast::Bool &node) {
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::BOOL;
        buffer.emit(lastReg + " = add i1 " + (node.value ? "1" : "0") + ", 0");
    }

    void MyVisitor::visit(ast::ID &node) {
        Symbol* sym = symbolTable.getSymbol(node.value);
        if (!sym) errorUndef(node.line, node.value);
        if (sym->isFunction) errorDefAsFunc(node.line, node.value);

        std::string ptr = sym->llvmVar;
        last_type = sym->type;
        std::string typeStr = getTypeStr(sym->type);
        lastReg = buffer.freshVar();
        buffer.emit(lastReg + " = load " + typeStr + ", " + typeStr + "* " + ptr);
    }

    void MyVisitor::visit(ast::BinOp &node) {
        node.left->accept(*this);
        std::string leftReg = lastReg;
        ast::BuiltInType leftType = last_type;

        node.right->accept(*this);
        std::string rightReg = lastReg;
        ast::BuiltInType rightType = last_type;

        // Determine common type (promote to INT if needed)
        ast::BuiltInType commonType = ast::BuiltInType::BYTE;
        if (leftType == ast::BuiltInType::INT || rightType == ast::BuiltInType::INT) {
            commonType = ast::BuiltInType::INT;
        }

        // Cast Left
        if (leftType != commonType) {
            if (leftType == ast::BuiltInType::BYTE && commonType == ast::BuiltInType::INT) {
                std::string newReg = buffer.freshVar();
                buffer.emit(newReg + " = zext i8 " + leftReg + " to i32");
                leftReg = newReg;
            }
        }

        // Cast Right
        if (rightType != commonType) {
            if (rightType == ast::BuiltInType::BYTE && commonType == ast::BuiltInType::INT) {
                std::string newReg = buffer.freshVar();
                buffer.emit(newReg + " = zext i8 " + rightReg + " to i32");
                rightReg = newReg;
            }
        }

        std::string typeStr = (commonType == ast::BuiltInType::INT) ? "i32" : "i8";

        // Check for division by zero
        if (node.op == ast::BinOpType::DIV) {
            std::string checkReg = buffer.freshVar();
            buffer.emit(checkReg + " = icmp eq " + typeStr + " " + rightReg + ", 0");

            std::string okLabel = buffer.freshLabel();
            std::string errorLabel = buffer.freshLabel();

            buffer.emit("br i1 " + checkReg + ", label %" + errorLabel + ", label %" + okLabel);

            buffer.emitLabel(errorLabel);
            buffer.emit("call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))");
            buffer.emit("call void @exit(i32 0)");
            buffer.emit("unreachable");

            buffer.emitLabel(okLabel);
        }

        std::string opCmd;
        switch (node.op) {
            case ast::BinOpType::ADD: opCmd = "add"; break;
            case ast::BinOpType::SUB: opCmd = "sub"; break;
            case ast::BinOpType::MUL: opCmd = "mul"; break;
            case ast::BinOpType::DIV:
                opCmd = (commonType == ast::BuiltInType::INT) ? "sdiv" : "udiv";
                break;
        }

        lastReg = buffer.freshVar();
        buffer.emit(lastReg + " = " + opCmd + " " + typeStr + " " + leftReg + ", " + rightReg);
        last_type = commonType;
    }

    void MyVisitor::visit(ast::RelOp &node) {
        node.left->accept(*this);
        std::string leftReg = lastReg;
        ast::BuiltInType leftType = last_type;

        node.right->accept(*this);
        std::string rightReg = lastReg;
        ast::BuiltInType rightType = last_type;

        // Determine common type for comparison
        ast::BuiltInType commonType = ast::BuiltInType::BYTE;
        if (leftType == ast::BuiltInType::INT || rightType == ast::BuiltInType::INT) {
            commonType = ast::BuiltInType::INT;
        }

        // Cast Left
        if (leftType != commonType) {
            std::string newReg = buffer.freshVar();
            buffer.emit(newReg + " = zext i8 " + leftReg + " to i32");
            leftReg = newReg;
        }
        // Cast Right
        if (rightType != commonType) {
            std::string newReg = buffer.freshVar();
            buffer.emit(newReg + " = zext i8 " + rightReg + " to i32");
            rightReg = newReg;
        }

        std::string typeStr = (commonType == ast::BuiltInType::INT) ? "i32" : "i8";
        std::string cmpMode;
        switch (node.op) {
            case ast::RelOpType::EQ: cmpMode = "eq"; break;
            case ast::RelOpType::NE: cmpMode = "ne"; break;
            case ast::RelOpType::LT: cmpMode = (commonType == ast::BuiltInType::INT ? "slt" : "ult"); break;
            case ast::RelOpType::GT: cmpMode = (commonType == ast::BuiltInType::INT ? "sgt" : "ugt"); break;
            case ast::RelOpType::LE: cmpMode = (commonType == ast::BuiltInType::INT ? "sle" : "ule"); break;
            case ast::RelOpType::GE: cmpMode = (commonType == ast::BuiltInType::INT ? "sge" : "uge"); break;
        }

        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::BOOL;
        buffer.emit(lastReg + " = icmp " + cmpMode + " " + typeStr + " " + leftReg + ", " + rightReg);
    }

    void MyVisitor::visit(ast::Not &node) {
        node.exp->accept(*this);
        std::string valReg = lastReg;
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::BOOL;
        buffer.emit(lastReg + " = xor i1 " + valReg + ", 1");
    }

    void MyVisitor::visit(ast::And &node) {
        node.left->accept(*this);
        std::string leftReg = lastReg;
        std::string checkRightLabel = buffer.freshLabel();
        std::string endLabel = buffer.freshLabel();

        std::string resPtr = buffer.freshVar();
        buffer.emit(resPtr + " = alloca i1");
        buffer.emit("store i1 0, i1* " + resPtr);

        buffer.emit("br i1 " + leftReg + ", label %" + checkRightLabel + ", label %" + endLabel);

        buffer.emitLabel(checkRightLabel);
        node.right->accept(*this);
        buffer.emit("store i1 " + lastReg + ", i1* " + resPtr);
        buffer.emit("br label %" + endLabel);

        buffer.emitLabel(endLabel);
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::BOOL;
        buffer.emit(lastReg + " = load i1, i1* " + resPtr);
    }

    void MyVisitor::visit(ast::Or &node) {
        std::string resPtr = buffer.freshVar();
        buffer.emit(resPtr + " = alloca i1");
        buffer.emit("store i1 1, i1* " + resPtr);

        node.left->accept(*this);
        std::string leftReg = lastReg;

        std::string checkRightLabel = buffer.freshLabel();
        std::string endLabel = buffer.freshLabel();

        buffer.emit("br i1 " + leftReg + ", label %" + endLabel + ", label %" + checkRightLabel);

        buffer.emitLabel(checkRightLabel);
        node.right->accept(*this);
        buffer.emit("store i1 " + lastReg + ", i1* " + resPtr);
        buffer.emit("br label %" + endLabel);

        buffer.emitLabel(endLabel);
        lastReg = buffer.freshVar();
        last_type = ast::BuiltInType::BOOL;
        buffer.emit(lastReg + " = load i1, i1* " + resPtr);
    }

    void MyVisitor::visit(ast::Type &node) {
    }

    void MyVisitor::visit(ast::Cast &node) {
        node.exp->accept(*this);
        emitCast(lastReg, last_type, node.target_type->type);
    }

    void MyVisitor::visit(ast::ExpList &node) {
    }

    void MyVisitor::visit(ast::Call &node) {
        std::string funcName = node.func_id->value;
        Symbol* sym = symbolTable.getSymbol(funcName);

        std::vector<std::string> argRegs;
        std::vector<ast::BuiltInType> argTypes;

        for (auto &exp : node.args->exps) {
            exp->accept(*this);
            argRegs.push_back(lastReg);
            argTypes.push_back(last_type);
        }

        std::string callStr = "call " + getTypeStr(sym->retType) + " @" + funcName + "(";

        for (size_t i = 0; i < argRegs.size(); ++i) {
            std::string reg = argRegs[i];
            ast::BuiltInType expected = sym->paramTypes[i];

            // Cast argument if necessary
            if (argTypes[i] != expected) {
                if (argTypes[i] == ast::BuiltInType::BYTE && expected == ast::BuiltInType::INT) {
                    std::string newReg = buffer.freshVar();
                    buffer.emit(newReg + " = zext i8 " + reg + " to i32");
                    reg = newReg;
                } else if (argTypes[i] == ast::BuiltInType::INT && expected == ast::BuiltInType::BYTE) {
                    std::string newReg = buffer.freshVar();
                    buffer.emit(newReg + " = trunc i32 " + reg + " to i8");
                    reg = newReg;
                }
            }

            callStr += getTypeStr(expected) + " " + reg;
            if (i < argRegs.size() - 1) callStr += ", ";
        }
        callStr += ")";

        if (sym->retType == ast::BuiltInType::VOID) {
            buffer.emit(callStr);
            lastReg = "0";
            last_type = ast::BuiltInType::VOID;
        } else {
            lastReg = buffer.freshVar();
            last_type = sym->retType;
            buffer.emit(lastReg + " = " + callStr);
        }
    }

    void MyVisitor::visit(ast::Statements &node) {
        symbolTable.pushScope();
        for (auto &stmt : node.statements) {
            stmt->accept(*this);
            if (blockTerminated) break;
        }
        symbolTable.popScope();
    }

    void MyVisitor::visit(ast::Break &node) {
        if (loopBreakLabels.empty()) errorUnexpectedBreak(node.line);
        buffer.emit("br label %" + loopBreakLabels.top());
        blockTerminated = true;
    }

    void MyVisitor::visit(ast::Continue &node) {
        if (loopContinueLabels.empty()) errorUnexpectedContinue(node.line);
        buffer.emit("br label %" + loopContinueLabels.top());
        blockTerminated = true;
    }

    void MyVisitor::visit(ast::Return &node) {
        if (node.exp) {
            node.exp->accept(*this);
            emitCast(lastReg, last_type, currentFuncRetType);
            buffer.emit("ret " + getTypeStr(currentFuncRetType) + " " + lastReg);
        } else {
            buffer.emit("ret void");
        }
        blockTerminated = true;
    }

    void MyVisitor::visit(ast::If &node) {
        symbolTable.pushScope();
        node.condition->accept(*this);
        std::string condReg = lastReg;

        std::string thenLabel = buffer.freshLabel();
        std::string elseLabel = buffer.freshLabel();
        std::string endLabel = buffer.freshLabel();

        buffer.emit("br i1 " + condReg + ", label %" + thenLabel + ", label %" + elseLabel);

        buffer.emitLabel(thenLabel);
        blockTerminated = false;
        node.then->accept(*this);
        if (!blockTerminated) {
            buffer.emit("br label %" + endLabel);
        }

        buffer.emitLabel(elseLabel);
        blockTerminated = false;
        if (node.otherwise) {
            node.otherwise->accept(*this);
        }
        if (!blockTerminated) {
            buffer.emit("br label %" + endLabel);
        }

        buffer.emitLabel(endLabel);
        blockTerminated = false;
        symbolTable.popScope();
    }

    void MyVisitor::visit(ast::While &node) {
        std::string condLabel = buffer.freshLabel();
        std::string bodyLabel = buffer.freshLabel();
        std::string endLabel = buffer.freshLabel();

        loopContinueLabels.push(condLabel);
        loopBreakLabels.push(endLabel);

        buffer.emit("br label %" + condLabel);

        buffer.emitLabel(condLabel);
        blockTerminated = false;
        node.condition->accept(*this);
        buffer.emit("br i1 " + lastReg + ", label %" + bodyLabel + ", label %" + endLabel);

        buffer.emitLabel(bodyLabel);
        blockTerminated = false;
        symbolTable.pushScope();
        node.body->accept(*this);
        symbolTable.popScope();

        if (!blockTerminated) {
            buffer.emit("br label %" + condLabel);
        }

        buffer.emitLabel(endLabel);
        blockTerminated = false;

        loopContinueLabels.pop();
        loopBreakLabels.pop();
    }

    void MyVisitor::visit(ast::VarDecl &node) {
        std::string typeStr = getTypeStr(node.type->type);
        std::string ptrVar = buffer.freshVar();
        buffer.emit(ptrVar + " = alloca " + typeStr);

        symbolTable.insertVar(node.id->value, node.type->type, ptrVar);

        if (node.init_exp) {
            node.init_exp->accept(*this);
            emitCast(lastReg, last_type, node.type->type);
            buffer.emit("store " + typeStr + " " + lastReg + ", " + typeStr + "* " + ptrVar);
        } else {
            buffer.emit("store " + typeStr + " " + getZeroValue(node.type->type) + ", " + typeStr + "* " + ptrVar);
        }
    }

    void MyVisitor::visit(ast::Assign &node) {
        Symbol* sym = symbolTable.getSymbol(node.id->value);
        if (!sym) errorUndef(node.line, node.id->value);

        node.exp->accept(*this);
        emitCast(lastReg, last_type, sym->type);

        std::string typeStr = getTypeStr(sym->type);
        buffer.emit("store " + typeStr + " " + lastReg + ", " + typeStr + "* " + sym->llvmVar);
    }

    void MyVisitor::visit(ast::Formal &node) {
    }

    void MyVisitor::visit(ast::Formals &node) {
    }

    void MyVisitor::visit(ast::FuncDecl &node) {
        symbolTable.pushScope();

        std::string funcName = node.id->value;
        currentFuncRetType = node.return_type->type;
        currentFuncEndLabel = buffer.freshLabel();

        std::string sig = "define " + getTypeStr(currentFuncRetType) + " @" + funcName + "(";

        std::vector<ast::BuiltInType> paramTypes;
        for (auto &formal : node.formals->formals) {
            paramTypes.push_back(formal->type->type);
        }

        for (size_t i = 0; i < paramTypes.size(); ++i) {
            sig += getTypeStr(paramTypes[i]);
            if (i < paramTypes.size() - 1) sig += ", ";
        }
        sig += ") {";
        buffer.emit(sig);

        buffer.emit("entry:");

        symbolTable.popScope();
        symbolTable.insertFunc(funcName, currentFuncRetType, paramTypes);
        symbolTable.pushScope();

        int argCounter = 0;
        for (auto &formal : node.formals->formals) {
            std::string typeStr = getTypeStr(formal->type->type);
            std::string ptrVar = buffer.freshVar();
            buffer.emit(ptrVar + " = alloca " + typeStr);
            buffer.emit("store " + typeStr + " %" + std::to_string(argCounter++) + ", " + typeStr + "* " + ptrVar);

            symbolTable.insertVar(formal->id->value, formal->type->type, ptrVar);
        }

        node.body->accept(*this);

        if (!blockTerminated) {
            buffer.emit("ret " + (currentFuncRetType == ast::BuiltInType::VOID ? "void" : getTypeStr(currentFuncRetType) + " 0"));
        }

        buffer.emit("}");
        buffer.emit("");

        symbolTable.popScope();
    }

    void MyVisitor::visit(ast::Funcs &node) {
        buffer.emitGlobal("@.str_div_err = constant [23 x i8] c\"Error division by zero\\00\"");

        for (auto &func : node.funcs) {
            func->accept(*this);
        }

        if (!symbolTable.contains("main")) errorMainMissing();
    }

} // namespace output