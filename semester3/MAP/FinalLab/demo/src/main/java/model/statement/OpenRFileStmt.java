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
import java.io.FileReader;
import java.io.IOException;

public class OpenRFileStmt implements IStmt {
    private final Exp exp;

    public OpenRFileStmt(Exp exp) {
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();
        Value val = exp.eval(state.getSymTable(), state.getHeap());

        if (!val.getType().equals(new StringType())) {
            throw new MyException("Expression in openRFile is not a string");
        }

        StringValue fileName = (StringValue) val;

        // Check if file is already open
        if (fileTable.isDefined(fileName)) {
            throw new MyException("File already opened: " + fileName.getVal());
        }

        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName.getVal()));
            fileTable.put(fileName, br);
        } catch (IOException e) {
            throw new MyException("Cannot open file: " + fileName.getVal());
        }

        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type expType = exp.typecheck(typeEnv);
        if (!expType.equals(new StringType()))
            throw new MyException("OpenRFile: expression is not string");
        return typeEnv;
    }

    @Override
    public String toString() {
        return "openRFile(" + exp.toString() + ")";
    }
}