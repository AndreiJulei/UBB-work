package model.state;

import exceptions.LanguageInterpreterADTException;
import model.adt.IDictionary;
import model.type.IType;
import model.value.IValue;

import java.util.HashMap;
import java.util.Map;

public class SymbolTable<K, V> implements IDictionary<K, V> {
    private final Map<K, V> map = new HashMap<>();

    @Override
    public boolean isDefined(K variableName) {
        return map.containsKey(variableName);
    }

    @Override
    public void declareVariable(K variableName, V value) throws LanguageInterpreterADTException {
        if (map.containsKey(variableName)) {
            throw new LanguageInterpreterADTException("Variable already defined");
        }
        map.put(variableName, value);
    }

    @Override
    public void update(K variableName, V value) throws LanguageInterpreterADTException {
        if (!map.containsKey(variableName)) {
            throw new LanguageInterpreterADTException("Variable not defined");
        }
        map.put(variableName, value);
    }

    @Override
    public V getValue(K variableName) throws LanguageInterpreterADTException {
        if (!map.containsKey(variableName)) {
            throw new LanguageInterpreterADTException("Variable not defined");
        }
        return map.get(variableName);
    }

    @Override
    public IDictionary<K, V> deepCopy() {
        SymbolTable<K, V> copy = new SymbolTable<>();

        for (Map.Entry<K, V> entry : map.entrySet()) {
            V value = entry.getValue();

            if (value instanceof IValue val) {
                @SuppressWarnings("unchecked")
                V copiedValue = (V) val.deepCopy();
                copy.map.put(entry.getKey(), copiedValue);
            } else if (value instanceof IType type) {
                @SuppressWarnings("unchecked")
                V copiedValue = (V) type.deepCopy();
                copy.map.put(entry.getKey(), copiedValue);
            } else {
                throw new RuntimeException(
                        "SymbolTable deepCopy: unsupported value type: " + value.getClass()
                );
            }
        }

        return copy;
    }

    @Override
    public Map<K, V> getAll() {
        return new HashMap<>(map);
    }
}
