package model.statements;

import exceptions.MyException;
import model.PrgState;
import model.adt.MyIStack;
import model.adt.MyStack;
import model.adt.MyIDictionary;
import model.adt.MyDictionary;
import model.adt.MyIHeap;
import model.adt.MyIList;
import model.values.StringValue;
import model.values.Value;
import model.types.Type;

import java.io.BufferedReader;
import java.util.Map;

public class ForkStmt implements IStmt {

    private final IStmt stmt;

    public ForkStmt(IStmt stmt) {
        this.stmt = stmt;
    }


    @Override
    public PrgState execute(PrgState state) throws MyException {

        MyIStack<IStmt> newStack = new MyStack<>();
        newStack.push(stmt);

        MyIDictionary<String, Value> parentSymTable = state.getSymTable();
        MyIDictionary<String, Value> newSymTable = parentSymTable.clone();

        MyIList<Value> out = state.getOut();
        MyIDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();
        MyIHeap<Value> heap = state.getHeap();

        PrgState forkedState = new PrgState(newStack, newSymTable, out, fileTable, heap);

        return forkedState;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return stmt.typecheck(typeEnv);
    }

    @Override
    public String toString() {
        return "fork(" + stmt.toString() + ")";
    }
}