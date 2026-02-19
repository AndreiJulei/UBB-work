package model.expression;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.adt.IHeap;
import model.type.BooleanType;
import model.type.IType;
import model.value.BooleanValue;
import model.value.IValue;


public record NotExpression(IExpression expression) implements IExpression {
    
    @Override
    public IValue evaluate(IDictionary<String, IValue> symTable, IHeap<Integer, IValue> heap) throws LanguageInterpreterException {
        IValue value = expression.evaluate(symTable, heap);
                if (!(value.getType() instanceof BooleanType)) {
            throw new LanguageInterpreterException("Not expression requires a boolean operand");
        }

        BooleanValue boolValue = (BooleanValue) value;
        return new BooleanValue(!boolValue.value());
    }

    @Override
    public IType typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType type = expression.typeCheck(typeEnv);
        if (!(type.equals(new BooleanType()))) {
            throw new LanguageInterpreterException("Not expression requires a boolean operand");
        }
        return new BooleanType();
    }

    public IExpression deepCopy(){
        return new NotExpression(expression.deepCopy());
    }

    @Override
    public String toString() {
        return "!(" + expression + ")";
    }



}
