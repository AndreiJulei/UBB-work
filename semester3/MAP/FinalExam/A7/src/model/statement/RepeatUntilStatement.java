package model.statement;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.expression.IExpression;
import model.expression.NotExpression;
import model.state.ProgramState;
import model.type.BooleanType;
import model.type.IType;

public record RepeatUntilStatement(IStatement statement, IExpression condition) implements IStatement {
    @Override 
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException{
        var stack = state.executionStack();
        IStatement whileStmt = new WhileStatement(
                new NotExpression(condition),
                statement
        );

        IStatement compoundStmt = new CompoundStatement(statement, whileStmt);

        stack.push(compoundStmt);
        return null;
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType condType = condition.typeCheck(typeEnv);
        if (!condType.equals(new BooleanType())) {
            throw new LanguageInterpreterException(
                    "The repeat-until condition must be a boolean, but got: " + condType
            );
        }

        statement.typeCheck(typeEnv.deepCopy());
        
        return typeEnv;
    }
    @Override
    public IStatement deepCopy() {
        return new RepeatUntilStatement(statement.deepCopy(), condition.deepCopy());
    }

    @Override
    public String toString() {
        return "repeat {" + statement + "} until (" + condition + ")";
    }

}
