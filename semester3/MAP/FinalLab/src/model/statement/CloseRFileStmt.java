package model.statements;

import exceptions.MyException;
import model.PrgState;
import model.adt.MyIDictionary;
import model.expressions.Exp;
import model.types.StringType;
import model.types.Type;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFileStmt implements IStmt {
    private final Exp exp; // expression evaluating to StringValue (file name)

    public CloseRFileStmt(Exp exp) {
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();

        Value val = exp.eval(symTable, state.getHeap());
        if (!val.getType().equals(new StringType()))
            throw new MyException("CloseRFile: expression is not a string.");

        StringValue fileName = (StringValue) val;

        if (!fileTable.isDefined(fileName))
            throw new MyException("CloseRFile: file " + fileName.getVal() + " not open.");

        BufferedReader br = fileTable.lookup(fileName);
        try {
            br.close();
        } catch (IOException e) {
            throw new MyException("Error closing file " + fileName.getVal());
        }

        fileTable.getContent().remove(fileName);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type expType = exp.typecheck(typeEnv);
        if (!expType.equals(new StringType()))
            throw new MyException("CloseRFile: expression is not string");
        return typeEnv;
    }

    @Override
    public String toString() {
        return "closeRFile(" + exp.toString() + ")";
    }
}