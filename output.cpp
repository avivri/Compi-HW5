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
        // HW5 requires handling strings in globals
        std::string var = "@.str" + std::to_string(++stringCount);
        // +1 for null terminator
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
        pushScope(); // Global scope
        
        // Add print and printi to global scope as per instructions
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
        // Offset is managed for Semantic checks, but for HW5 LLVM we primarily need the llvmVar name (pointer)
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
        // Emit required external declarations
        buffer.emitGlobal("declare i32 @printf(i8*, ...)");
        buffer.emitGlobal("declare void @exit(i32)");
        
        // Emit helper print functions provided in the PDF/Skeleton
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
            case ast::BuiltInType::STRING: return "i8*"; // Strings are pointers
            default: return "i32";
        }
    }

    std::string MyVisitor::getZeroValue(ast::BuiltInType type) {
        if (type == ast::BuiltInType::BOOL) return "0"; 
        return "0";
    }

    void MyVisitor::emitPrintFunctions() {
        // Define string specifiers for printf
        buffer.emitGlobal("@.int_specifier = constant [4 x i8] c\"%d\\0A\\00\"");
        buffer.emitGlobal("@.str_specifier = constant [4 x i8] c\"%s\\0A\\00\"");
        
        // printi
        buffer.emitGlobal("define void @printi(i32) {");
        buffer.emitGlobal("  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.int_specifier, i32 0, i32 0");
        buffer.emitGlobal("  call i32 (i8*, ...) @printf(i8* %spec_ptr, i32 %0)");
        buffer.emitGlobal("  ret void");
        buffer.emitGlobal("}");

        // print
        buffer.emitGlobal("define void @print(i8*) {");
        buffer.emitGlobal("  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.str_specifier, i32 0, i32 0");
        buffer.emitGlobal("  call i32 (i8*, ...) @printf(i8* %spec_ptr, i8* %0)");
        buffer.emitGlobal("  ret void");
        buffer.emitGlobal("}");
    }

    // --- Nodes Visitation ---

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
        // Get pointer to start of string
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
        last_type = sym->type; // Set type for parents
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

        // Check for division by zero
        if (node.op == ast::BinOpType::DIV) {
            std::string typeStr = (leftType == ast::BuiltInType::INT) ? "i32" : "i8";
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
        std::string typeStr = "i32"; // Default for int
        if (leftType == ast::BuiltInType::BYTE) typeStr = "i8";

        switch (node.op) {
            case ast::BinOpType::ADD: opCmd = "add"; break;
            case ast::BinOpType::SUB: opCmd = "sub"; break;
            case ast::BinOpType::MUL: opCmd = "mul"; break;
            case ast::BinOpType::DIV: 
                opCmd = (typeStr == "i32") ? "sdiv" : "udiv"; 
                break;
        }

        lastReg = buffer.freshVar();
        buffer.emit(lastReg + " = " + opCmd + " " + typeStr + " " + leftReg + ", " + rightReg);

        // Result type propogation
        last_type = leftType; // Basic type inference (int op int -> int, byte op byte -> byte)
        
        // Byte truncation or mixed type handling if necessary
        if (typeStr == "i8" && node.type == ast::BuiltInType::INT) {
             // Note: In strict Aviri AST, Exp has 'type' enum member, not node.type.type
             // But we are using last_type to track.
             // If we needed to cast up:
             // std::string oldReg = lastReg;
             // lastReg = buffer.freshVar();
             // buffer.emit(lastReg + " = zext i8 " + oldReg + " to i32");
             // last_type = ast::BuiltInType::INT;
        }
    }

    void MyVisitor::visit(ast::RelOp &node) {
        node.left->accept(*this);
        std::string leftReg = lastReg;
        ast::BuiltInType leftType = last_type;
        
        node.right->accept(*this);
        std::string rightReg = lastReg;
        
        std::string typeStr = "i32";
        if (leftType == ast::BuiltInType::BYTE) typeStr = "i8";

        std::string cmpMode;
        switch (node.op) {
            case ast::RelOpType::EQ: cmpMode = "eq"; break;
            case ast::RelOpType::NE: cmpMode = "ne"; break;
            case ast::RelOpType::LT: cmpMode = (typeStr == "i32" ? "slt" : "ult"); break;
            case ast::RelOpType::GT: cmpMode = (typeStr == "i32" ? "sgt" : "ugt"); break;
            case ast::RelOpType::LE: cmpMode = (typeStr == "i32" ? "sle" : "ule"); break;
            case ast::RelOpType::GE: cmpMode = (typeStr == "i32" ? "sge" : "uge"); break;
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
        // Short circuit evaluation
        node.left->accept(*this);
        std::string leftReg = lastReg;
        std::string leftLabel = buffer.freshLabel(); 
        std::string checkRightLabel = buffer.freshLabel();
        std::string endLabel = buffer.freshLabel();
        
        // Stack pointer for result
        std::string resPtr = buffer.freshVar();
        buffer.emit(resPtr + " = alloca i1");
        buffer.emit("store i1 0, i1* " + resPtr); // Default false
        
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
        buffer.emit("store i1 1, i1* " + resPtr); // Default true
        
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
        // Nothing to emit
    }

    void MyVisitor::visit(ast::Cast &node) {
        node.exp->accept(*this);
        ast::BuiltInType expType = last_type;
        // target_type is a Type node, so it has a 'type' enum field.
        
        if (node.target_type->type == ast::BuiltInType::INT && expType == ast::BuiltInType::BYTE) {
            std::string oldReg = lastReg;
            lastReg = buffer.freshVar();
            last_type = ast::BuiltInType::INT;
            buffer.emit(lastReg + " = zext i8 " + oldReg + " to i32");
        }
        else if (node.target_type->type == ast::BuiltInType::BYTE && expType == ast::BuiltInType::INT) {
            std::string oldReg = lastReg;
            lastReg = buffer.freshVar();
            last_type = ast::BuiltInType::BYTE;
            buffer.emit(lastReg + " = trunc i32 " + oldReg + " to i8");
        }
        else {
             // If types are same or other cast, just propagate
             last_type = node.target_type->type;
        }
    }

    void MyVisitor::visit(ast::ExpList &node) {
        // Evaluated in Call
    }

    void MyVisitor::visit(ast::Call &node) {
        std::string funcName = node.func_id->value;
        Symbol* sym = symbolTable.getSymbol(funcName);

        std::vector<std::string> argRegs;
        std::vector<ast::BuiltInType> argTypes; // We must track argument types

        // 1. Evaluate arguments
        for (auto &exp : node.args->exps) {
            exp->accept(*this);
            argRegs.push_back(lastReg);
            argTypes.push_back(last_type); // Capture the type
        }

        // 2. Build call string with casting
        std::string callStr = "call " + getTypeStr(sym->retType) + " @" + funcName + "(";

        for (size_t i = 0; i < argRegs.size(); ++i) {
            std::string reg = argRegs[i];
            ast::BuiltInType argType = argTypes[i];
            ast::BuiltInType paramType = sym->paramTypes[i];

            // Fix: Explicitly cast Byte to Int if required
            if (argType == ast::BuiltInType::BYTE && paramType == ast::BuiltInType::INT) {
                std::string newReg = buffer.freshVar();
                buffer.emit(newReg + " = zext i8 " + reg + " to i32");
                reg = newReg;
            }

            callStr += getTypeStr(paramType) + " " + reg;
            if (i < argRegs.size() - 1) callStr += ", ";
        }
        callStr += ")";

        // 3. Emit call
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

        // THEN Block
        buffer.emitLabel(thenLabel);
        blockTerminated = false; // Reset for new block
        node.then->accept(*this);
        if (!blockTerminated) {  // Only emit branch if NOT terminated
            buffer.emit("br label %" + endLabel);
        }

        // ELSE Block
        buffer.emitLabel(elseLabel);
        blockTerminated = false; // Reset for new block
        if (node.otherwise) {
            node.otherwise->accept(*this);
        }
        if (!blockTerminated) {  // Only emit branch if NOT terminated
            buffer.emit("br label %" + endLabel);
        }

        // END Block
        buffer.emitLabel(endLabel);
        blockTerminated = false; // Reset for flow continuation
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
        blockTerminated = false; // Reset
        node.condition->accept(*this);
        buffer.emit("br i1 " + lastReg + ", label %" + bodyLabel + ", label %" + endLabel);

        buffer.emitLabel(bodyLabel);
        blockTerminated = false; // Reset
        symbolTable.pushScope();
        node.body->accept(*this);
        symbolTable.popScope();

        if (!blockTerminated) { // Only loop back if NOT terminated
            buffer.emit("br label %" + condLabel);
        }

        buffer.emitLabel(endLabel);
        blockTerminated = false; // Reset

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
            buffer.emit("store " + typeStr + " " + lastReg + ", " + typeStr + "* " + ptrVar);
        } else {
            // Initialize to 0
            buffer.emit("store " + typeStr + " " + getZeroValue(node.type->type) + ", " + typeStr + "* " + ptrVar);
        }
    }

    void MyVisitor::visit(ast::Assign &node) {
        Symbol* sym = symbolTable.getSymbol(node.id->value);
        if (!sym) errorUndef(node.line, node.id->value);
        
        node.exp->accept(*this);
        std::string typeStr = getTypeStr(sym->type);
        buffer.emit("store " + typeStr + " " + lastReg + ", " + typeStr + "* " + sym->llvmVar);
    }

    void MyVisitor::visit(ast::Formal &node) {
        // Handled in FuncDecl
    }

    void MyVisitor::visit(ast::Formals &node) {
        // Handled in FuncDecl
    }

    void MyVisitor::visit(ast::FuncDecl &node) {
        symbolTable.pushScope(); // Function scope
        
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
        
        // Insert func to global table manually (hack for single pass visitor)
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
        
        buffer.emit("ret " + (currentFuncRetType == ast::BuiltInType::VOID ? "void" : getTypeStr(currentFuncRetType) + " 0"));
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