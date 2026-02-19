package model.statement;

import exceptions.LanguageInterpreterADTException;
import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.state.ProgramState;
import model.type.IType;

public record VariableDeclarationStatement(IType type, String variableName) implements IStatement {

    @Override
    public String toString() {
        return type.toString() + " " + variableName;
    }

    public IStatement deepCopy() {
        return new VariableDeclarationStatement(type.deepCopy(), variableName);
    }

    @Override
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException {
        var symbolTable = state.symbolTable();

        try {
            symbolTable.declareVariable(variableName, type.getDefaultValue());
        }
        catch (LanguageInterpreterADTException e) {
            throw new LanguageInterpreterException(e.getMessage());
        }

        return null;
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        typeEnv.declareVariable(variableName, type);
        return typeEnv;
    }
}
