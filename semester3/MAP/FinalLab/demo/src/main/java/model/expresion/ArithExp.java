package model.expressions;

import exceptions.MyException;
import model.adt.MyIDictionary;
import model.adt.MyIHeap;
import model.types.IntType;
import model.types.Type;
import model.values.IntValue;
import model.values.Value;

public class ArithExp implements Exp {
    private final Exp e1;
    private final Exp e2;
    private final int op; //1-plus, 2-minus, 3-star, 4-divide

    public ArithExp(char op, Exp e1, Exp e2) {
        this.e1 = e1;
        this.e2 = e2;
        if (op == '+') this.op = 1;
        else if (op == '-') this.op = 2;
        else if (op == '*') this.op = 3;
        else if (op == '/') this.op = 4;
        else this.op = 0; 
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTable, MyIHeap<Value> heap) throws MyException {
        Value v1, v2;
        v1 = e1.eval(symTable, heap);
        if (v1.getType().equals(new IntType())) {
            v2 = e2.eval(symTable, heap);
            if (v2.getType().equals(new IntType())) {
                IntValue i1 = (IntValue) v1;
                IntValue i2 = (IntValue) v2;
                int n1, n2;
                n1 = i1.getVal();
                n2 = i2.getVal();
                if (op == 1) return new IntValue(n1 + n2);
                if (op == 2) return new IntValue(n1 - n2);
                if (op == 3) return new IntValue(n1 * n2);
                if (op == 4) {
                    if (n2 == 0) throw new MyException("division by zero");
                    else return new IntValue(n1 / n2);
                }
            } else {
                throw new MyException("second operand is not an integer");
            }
        } else {
            throw new MyException("first operand is not an integer");
        }
        return null; // Should not be reached
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t1 = e1.typecheck(typeEnv);
        Type t2 = e2.typecheck(typeEnv);
        if (t1.equals(new IntType()) && t2.equals(new IntType()))
            return new IntType();
        throw new MyException("Arithmetic operation requires integer operands");
    }

    @Override
    public String toString() {
        String operation = "";
        if (op == 1) operation = "+";
        if (op == 2) operation = "-";
        if (op == 3) operation = "*";
        if (op == 4) operation = "/";
        return e1.toString() + " " + operation + " " + e2.toString();
    }
}