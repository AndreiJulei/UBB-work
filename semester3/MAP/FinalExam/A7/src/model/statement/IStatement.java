package model.statement;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.state.ProgramState;
import model.type.IType;

public interface IStatement {
    ProgramState execute(ProgramState state) throws LanguageInterpreterException;

    IDictionary<String, IType> typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException;

    IStatement deepCopy();
}
