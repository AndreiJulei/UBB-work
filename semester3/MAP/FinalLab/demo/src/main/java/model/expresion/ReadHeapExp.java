package model.expressions;

import exceptions.MyException;
import model.adt.MyIDictionary;
import model.adt.MyIHeap;
import model.types.RefType;
import model.types.Type;
import model.values.RefValue;
import model.values.Value;

public class ReadHeapExp implements Exp {
    private final Exp exp;

    public ReadHeapExp(Exp exp) {
        this.exp = exp;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap<Value> heap) throws MyException {
        Value val = exp.eval(symTable, heap);
        if (!(val instanceof RefValue))
            throw new MyException("readHeap argument is not a RefValue");

        int addr = ((RefValue) val).getAddress();
        return heap.get(addr);
    }
    
    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t = exp.typecheck(typeEnv);

        if (!(t instanceof RefType))
            throw new MyException("rH: argument is not a RefType");

        return ((RefType) t).getInner();
    }

    @Override
    public String toString() {
        return "rH(" + exp.toString() + ")";
    }
}
