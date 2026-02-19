package model.statement;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.expression.IExpression;
import model.state.ProgramState;
import model.type.BooleanType;
import model.type.IType;
import model.value.BooleanValue;
import model.value.IValue;

import java.util.Objects;

public record WhileStatement(IExpression condition, IStatement body) implements IStatement {

    @Override
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException {
        var stack = state.executionStack();
        var symbolTable = state.symbolTable();
        var heap = state.heap();

        IValue condValue = condition.evaluate(symbolTable, heap);

        if (!Objects.equals(condValue.getType(), new BooleanType()))
            throw new LanguageInterpreterException("While statement condition is not a boolean: " + condValue);

        BooleanValue boolVal = (BooleanValue) condValue;

        if (boolVal.value()) {
            stack.push(this);
            stack.push(body);
        }

        return null;
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType condType = condition.typeCheck(typeEnv);

        if (!condType.equals(new BooleanType())) {
            throw new LanguageInterpreterException(
                    "The while condition must be a boolean."
            );
        }

        body.typeCheck(typeEnv.deepCopy());

        return typeEnv;
    }


    @Override
    public IStatement deepCopy() {
        return new WhileStatement(condition.deepCopy(), body.deepCopy());
    }

    @Override
    public String toString() {
        return "while(" + condition + ") {" + body + "}";
    }
}
