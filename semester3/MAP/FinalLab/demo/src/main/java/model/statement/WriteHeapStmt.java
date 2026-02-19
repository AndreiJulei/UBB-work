package model.statements;

import exceptions.MyException;
import model.PrgState;
import model.adt.MyIHeap;
import model.adt.MyIDictionary;
import model.expressions.Exp;
import model.types.RefType;
import model.types.Type;
import model.values.RefValue;
import model.values.Value;

public class WriteHeapStmt implements IStmt {
    private final String varName;
    private final Exp exp;

    public WriteHeapStmt(String varName, Exp exp) {
        this.varName = varName;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        if (!symTable.isDefined(varName))
            throw new MyException("Variable " + varName + " not defined");

        Value varVal = symTable.lookup(varName);

        if (!(varVal instanceof RefValue))
            throw new MyException(varName + " is not a RefValue");

        int addr = ((RefValue) varVal).getAddress();
        if (!heap.contains(addr))
            throw new MyException("Invalid heap address");

        Value expVal = exp.eval(symTable, heap);

        if (!expVal.getType().equals(((RefValue) varVal).getLocationType()))
            throw new MyException("Type mismatch in writeHeap");

        heap.put(addr, expVal);

        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type varType = typeEnv.lookup(varName);
        Type expType = exp.typecheck(typeEnv);

        if (!(varType instanceof RefType))
            throw new MyException("writeHeap: variable is not RefType");

        RefType refT = (RefType) varType;
        if (!expType.equals(refT.getInner()))
            throw new MyException("writeHeap: value type does not match referenced type");

        return typeEnv;
    }
    
    @Override
    public String toString() {
        return "wH(" + varName + ", " + exp.toString() + ")";
    }
}
