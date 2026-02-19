package model.expression;

import exceptions.LanguageInterpreterException;
import model.adt.IDictionary;
import model.adt.IHeap;
import model.type.IType;
import model.type.IntegerType;
import model.value.IValue;
import model.value.IntegerValue;

public record ArithmeticExpression(String operator, IExpression left, IExpression right)
        implements IExpression {

    @Override
    public String toString() {
        return "(" + left.toString() + " " + operator + " " + right.toString() + ")";
    }

    @Override
    public IValue evaluate(IDictionary<String, IValue> symTable, IHeap<Integer, IValue> heap) throws LanguageInterpreterException {
        var leftTerm = left.evaluate(symTable, heap);
        var rightTerm = right.evaluate(symTable, heap);

        if (!(leftTerm.getType() instanceof IntegerType) || !(rightTerm.getType() instanceof IntegerType)) {
            throw new LanguageInterpreterException("Arithmetic operands must be integers");
        }

        var leftValue = (IntegerValue) leftTerm;
        var rightValue = (IntegerValue) rightTerm;

        return switch (operator) {
            case "+" -> new IntegerValue(leftValue.value() + rightValue.value());
            case "-" -> new IntegerValue(leftValue.value() - rightValue.value());
            case "*" -> new IntegerValue(leftValue.value() * rightValue.value());
            case "/" -> {
                if (rightValue.value() == 0) {
                    throw new LanguageInterpreterException("Division by zero");
                }
                yield new IntegerValue(leftValue.value() / rightValue.value());
            }
            default -> throw new LanguageInterpreterException("Invalid arithmetic operator: " + operator);
        };
    }

    @Override
    public IType typeCheck(IDictionary<String, IType> typeEnv) throws LanguageInterpreterException {
        IType leftType = left.typeCheck(typeEnv);
        IType rightType = right.typeCheck(typeEnv);

        if(!(leftType.equals(new IntegerType()))) {
            throw new LanguageInterpreterException("First operand must be an integer");
        }

        if(!(rightType.equals(new IntegerType()))) {
            throw new LanguageInterpreterException("Second operand must be an integer");
        }

        return new IntegerType();
    }

    @Override
    public IExpression deepCopy() {
        return new ArithmeticExpression(operator, left.deepCopy(), right.deepCopy());
    }
}
