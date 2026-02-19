package model.statements;

import exceptions.MyException;
import model.PrgState;
import model.adt.MyIDictionary;
import model.expressions.Exp;
import model.types.IntType;
import model.types.StringType;
import model.types.Type;
import model.values.IntValue;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class ReadFileStmt implements IStmt {
    private final Exp exp; 
    private final String varName; 

    public ReadFileStmt(Exp exp, String varName) {
        this.exp = exp;
        this.varName = varName;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();

        if (!symTable.isDefined(varName))
            throw new MyException("Variable " + varName + " not defined.");

        Value val = symTable.lookup(varName);
        if (!val.getType().equals(new IntType()))
            throw new MyException(varName + " is not of type int.");

        Value fileNameVal = exp.eval(symTable, state.getHeap());
        if (!fileNameVal.getType().equals(new StringType()))
            throw new MyException("Expression " + exp + " is not a string.");

        StringValue fileName = (StringValue) fileNameVal;

        if (!fileTable.isDefined(fileName))
            throw new MyException("File " + fileName.getVal() + " not found in FileTable.");

        BufferedReader br = fileTable.lookup(fileName);
        try {
            String line = br.readLine();
            int valRead;
            if (line == null)
                valRead = 0;
            else
                valRead = Integer.parseInt(line);

            symTable.update(varName, new IntValue(valRead));
        } catch (IOException e) {
            throw new MyException("Error reading from file " + fileName.getVal());
        } catch (NumberFormatException e) {
            throw new MyException("Invalid integer in file " + fileName.getVal());
        }

        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type varType = typeEnv.lookup(varName);
        Type expType = exp.typecheck(typeEnv);
        if (!varType.equals(new IntType()))
            throw new MyException("ReadFile: variable is not int");
        if (!expType.equals(new StringType()))
            throw new MyException("ReadFile: expression is not string");
        return typeEnv;
    }

    @Override
    public String toString() {
        return "readFile(" + exp.toString() + ", " + varName + ")";
    }
}