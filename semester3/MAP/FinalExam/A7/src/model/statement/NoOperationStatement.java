package model.statement;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.state.ProgramState;
import model.type.IType;

public class NoOperationStatement implements IStatement {
    @Override
    public String  toString()
    {
        return "";
    }

    @Override
    public ProgramState execute(ProgramState state) throws LanguageInterpreterException {
        return null;
    }

    @Override
    public IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        return typeEnv;
    }

    @Override
    public IStatement deepCopy() {
        return new NoOperationStatement();
    }
}
