package model.statements;

import exceptions.MyException;
import model.PrgState;
import model.adt.MyIStack;
import model.adt.MyIDictionary;
import model.adt.MyIHeap;
import model.expressions.Exp;
import model.types.BoolType;
import model.types.Type;
import model.values.BoolValue;
import model.values.Value;

public class WhileStmt implements IStmt {

    private final Exp exp;
    private final IStmt stmt;

    public WhileStmt(Exp exp, IStmt stmt) {
        this.exp = exp;
        this.stmt = stmt;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {

        MyIStack<IStmt> stack = state.getStk();
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        Value cond = exp.eval(symTable, heap);

        if (!cond.getType().equals(new BoolType())) {
            throw new MyException("While condition is not boolean.");
        }

        if (((BoolValue) cond).getVal()) {
            stack.push(this);      // push whole loop again
            stack.push(stmt);      // push loop body
        }

        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type condType = exp.typecheck(typeEnv);

        if (!condType.equals(new BoolType()))
            throw new MyException("While condition is not boolean");

        stmt.typecheck(typeEnv);
        return typeEnv;
    }

    @Override
    public String toString() {
        return "while(" + exp + ") " + stmt;
    }
}
