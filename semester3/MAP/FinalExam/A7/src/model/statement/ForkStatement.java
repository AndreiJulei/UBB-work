package model.statement;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.adt.IStack;
import model.state.ExecutionStack;
import model.state.ProgramState;
import model.state.SymbolTable;
import model.type.IType;
import model.value.IValue;

public record ForkStatement(IStatement statement) implements IStatement {

    @Override
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException {

        var parentHeap = state.heap();
        var parentFileTable = state.fileTable();
        var parentOut = state.out();
        var parentSymTable = state.symbolTable();

        // Create a new symbol table for the child (deep copy)
        IDictionary<String, IValue> childSymTable = new SymbolTable<>();
        for (var key : parentSymTable.getAll().keySet()) {
            IValue value = parentSymTable.getValue(key);
            childSymTable.declareVariable(key, value.deepCopy());
        }

        IStack<IStatement> childStack = new ExecutionStack<>();
        childStack.push(statement);

        return new ProgramState(
                childStack,
                childSymTable,
                parentFileTable,
                parentOut,
                parentHeap,
                null
        );
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IDictionary<String, IType> forkEnv = typeEnv.deepCopy();

        statement.typeCheck(forkEnv);
        return typeEnv;
    }

    @Override
    public IStatement deepCopy() {
        return new ForkStatement(statement.deepCopy());
    }

    @Override
    public String toString() {
        return "fork(" + statement + ")";
    }
}
