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

public class NewStmt implements IStmt {
    private final String varName;
    private final Exp exp;

    public NewStmt(String varName, Exp exp) {
        this.varName = varName;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        // 1. Type check and variable definition checks (all existing logic is correct)
        if (!symTable.isDefined(varName))
            throw new MyException("Variable " + varName + " is not defined");

        Value varVal = symTable.lookup(varName);
        if (!(varVal.getType() instanceof RefType))
            throw new MyException("Variable " + varName + " is not a RefType");

        Value expVal = exp.eval(symTable, heap);
        RefType refType = (RefType) varVal.getType();

        if (!expVal.getType().equals(refType.getInner()))
            throw new MyException("Type mismatch: cannot store value in referenced location");

        // 2. Allocate on heap and update SymTable
        int addr = heap.allocate(expVal);
        symTable.update(varName, new RefValue(addr, refType.getInner()));

        // 3. CORRECT FIX: Return null to signal that execution should continue to the next statement
        return null; // <--- This must be null for non-forking statements!
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type varType = typeEnv.lookup(varName);
        Type expType = exp.typecheck(typeEnv);

        if (!(varType instanceof RefType))
            throw new MyException("NEW stmt: variable is not RefType");

        RefType refT = (RefType) varType;
        if (!expType.equals(refT.getInner()))
            throw new MyException("NEW stmt: inner type mismatch");

        return typeEnv;
    }

    @Override
    public String toString() {
        return "new(" + varName + ", " + exp.toString() + ")";
    }
}