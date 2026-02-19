package model.statement;

import exceptions.LanguageInterpreterADTException;
import exceptions.LanguageInterpreterException;
import model.expression.IExpression;
import model.adt.IDictionary;
import model.state.ProgramState;
import model.type.IType;
import model.value.IValue;

public record AssignmentStatement(IExpression expression, String variableName)
        implements IStatement {

    @Override
    public String toString() {
        return variableName + "=" + expression.toString();
    }

    @Override
    public IStatement deepCopy() {
        return new AssignmentStatement(expression.deepCopy(), variableName);
    }

    @Override
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException {
        var symbolTable = state.symbolTable();
        var heap = state.heap();

        try {
            IValue value = expression.evaluate(symbolTable, heap);

            if (!value.getType().equals(symbolTable.getValue(variableName).getType())) {
                throw new LanguageInterpreterException("Variable type mismatch");
            }

            symbolTable.update(variableName, value);
            return null;
        }
        catch (LanguageInterpreterADTException e) {
            throw new LanguageInterpreterException(e.getMessage());
        }
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType variableType = typeEnv.getValue(variableName);
        IType expressionType = expression.typeCheck(typeEnv);

        if (!variableType.equals(expressionType))
            throw new LanguageInterpreterException("Variable type mismatch");

        return typeEnv;
    }
}
