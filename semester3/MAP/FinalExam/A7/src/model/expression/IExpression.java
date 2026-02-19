package model.expression;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.adt.IHeap;
import model.type.IType;
import model.value.IValue;

public interface IExpression {
    IValue evaluate(IDictionary<String, IValue> symTable, IHeap<Integer, IValue> heap) throws LanguageInterpreterException;

    IType typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException;

    IExpression deepCopy();
}
