package model.statement;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.expression.IExpression;
import model.state.ProgramState;
import model.type.BooleanType;
import model.type.IType;
import model.value.BooleanValue;
import model.value.IValue;

public record IfStatement(IExpression condition, IStatement thenBranch, IStatement elseBranch) implements IStatement {
    @Override
    public String toString() {
        return "if (" + condition.toString() + ") " + "then (" + thenBranch.toString() + ") " + "else (" + elseBranch.toString() + ")";
    }

    @Override
    public IStatement deepCopy() {
        return new IfStatement(condition.deepCopy(), thenBranch.deepCopy(), elseBranch.deepCopy());
    }

    @Override
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException {
        var symbolTable = state.symbolTable();
        var heap = state.heap();

        IValue result = condition.evaluate(symbolTable, heap);

        if (result instanceof BooleanValue(boolean value)) {
            if (value) {
                state.executionStack().push(thenBranch);
            } else {
                state.executionStack().push(elseBranch);
            }
        } else {
            throw new LanguageInterpreterException("Condition expression does not evaluate to a boolean.");
        }
        return null;
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType conditionType = condition.typeCheck(typeEnv);

        if (!conditionType.equals(new BooleanType())) {
            throw new LanguageInterpreterException("Condition expression does not evaluate to a boolean.");
        }

        thenBranch.typeCheck(typeEnv.deepCopy());
        elseBranch.typeCheck(typeEnv.deepCopy());

        return typeEnv;
    }
}
