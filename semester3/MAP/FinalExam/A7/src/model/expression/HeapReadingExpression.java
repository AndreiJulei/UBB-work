package model.expression;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.adt.IHeap;
import model.type.IType;
import model.type.ReferenceType;
import model.value.IValue;
import model.value.ReferenceValue;

public record HeapReadingExpression(IExpression expression) implements IExpression {

    @Override
    public IValue evaluate(IDictionary<String, IValue> symbolTable,
                           IHeap<Integer, IValue> heap) throws LanguageInterpreterException {

        IValue value = expression.evaluate(symbolTable, heap);

        if (!(value instanceof ReferenceValue refValue))
            throw new LanguageInterpreterException(
                    "Expression " + expression + " evaluated to a non-reference value: " + value);

        int address = refValue.address();

        if (!heap.isDefined(address))
            throw new LanguageInterpreterException(
                    "Address " + address + " is not allocated.");

        return heap.get(address);
    }

    @Override
    public IType typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType expressionType = expression.typeCheck(typeEnv);

        if (!(expressionType instanceof ReferenceType(IType inner))) {
            throw new LanguageInterpreterException("The operand be a reference type");
        }

        return inner;
    }

    @Override
    public String toString() {
        return "readHeap(" + expression + ")";
    }

    @Override
    public IExpression deepCopy() {
        return new HeapReadingExpression(expression.deepCopy());
    }
}
