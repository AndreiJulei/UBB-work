package model.values;

import model.types.IntType;
import model.types.Type;

public class IntValue implements Value {
    private final int val;

    public IntValue(int v) {
        this.val = v;
    }

    public int getVal() {
        return val;
    }

    @Override
    public String toString() {
        return String.valueOf(val);
    }

    @Override
    public Type getType() {
        return new IntType();
    }

    @Override
    public boolean equals(Object another) {
        return another instanceof IntValue && ((IntValue) another).getVal() == this.val;
    }

    @Override
    public Value deepCopy() {
        return new IntValue(val);
    }
}