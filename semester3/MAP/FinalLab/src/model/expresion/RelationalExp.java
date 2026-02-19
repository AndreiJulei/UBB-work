package model.expressions;

import exceptions.MyException;
import model.adt.MyIDictionary;
import model.adt.MyIHeap;
import model.types.BoolType;
import model.types.IntType;
import model.types.Type;
import model.values.BoolValue;
import model.values.IntValue;
import model.values.Value;

public class RelationalExp implements Exp {
    private final Exp e1;
    private final Exp e2;
    private final int op; // 1-<, 2-<=, 3-==, 4-!=, 5->, 6->=

    public RelationalExp(String op, Exp e1, Exp e2) {
        this.e1 = e1;
        this.e2 = e2;

        switch (op) {
            case "<"  -> this.op = 1;
            case "<=" -> this.op = 2;
            case "==" -> this.op = 3;
            case "!=" -> this.op = 4;
            case ">"  -> this.op = 5;
            case ">=" -> this.op = 6;
            default   -> this.op = 0; 
        }
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap<Value> heap) throws MyException {
        Value v1 = e1.eval(symTable, heap);
        if (!v1.getType().equals(new IntType()))
            throw new MyException("First operand is not an integer");

        Value v2 = e2.eval(symTable, heap);
        if (!v2.getType().equals(new IntType()))
            throw new MyException("Second operand is not an integer");

        IntValue i1 = (IntValue) v1;
        IntValue i2 = (IntValue) v2;
        int n1 = i1.getVal();
        int n2 = i2.getVal();

        return switch (op) {
            case 1 -> new BoolValue(n1 < n2);
            case 2 -> new BoolValue(n1 <= n2);
            case 3 -> new BoolValue(n1 == n2);
            case 4 -> new BoolValue(n1 != n2);
            case 5 -> new BoolValue(n1 > n2);
            case 6 -> new BoolValue(n1 >= n2);
            default -> throw new MyException("Invalid relational operator");
        };
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t1 = e1.typecheck(typeEnv);
        Type t2 = e2.typecheck(typeEnv);
        if (t1.equals(new IntType()) && t2.equals(new IntType()))
            return new BoolType();
        throw new MyException("Relational operation requires integer operands");
    }

    @Override
    public String toString() {
        String operation = switch (op) {
            case 1 -> "<";
            case 2 -> "<=";
            case 3 -> "==";
            case 4 -> "!=";
            case 5 -> ">";
            case 6 -> ">=";
            default -> "?";
        };
        return e1.toString() + " " + operation + " " + e2.toString();
    }
}
