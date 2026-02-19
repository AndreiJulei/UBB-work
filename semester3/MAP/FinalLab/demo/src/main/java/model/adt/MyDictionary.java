package model.adt;

import exceptions.MyException;
import java.util.HashMap;
import java.util.Map;

public class MyDictionary<K, V> implements MyIDictionary<K, V> {
    private final Map<K, V> dictionary;

    public MyDictionary() {
        this.dictionary = new HashMap<>();
    }

    @Override
    public boolean isDefined(K key) {
        return dictionary.containsKey(key);
    }

    @Override
    public V lookup(K key) throws MyException {
        if (!isDefined(key)) {
            throw new MyException(key + " is not defined.");
        }
        return dictionary.get(key);
    }

    @Override
    public void update(K key, V value) {
        dictionary.put(key, value);
    }
    
    @Override
    public void put(K key, V value) {
        dictionary.put(key, value);
    }

    @Override
    public Map<K, V> getContent() {
        return dictionary;
    }

    @Override
    public String toString() {
        return dictionary.toString();
    }

    @Override
    public MyDictionary<K, V> clone() {
        MyDictionary<K, V> cloned = new MyDictionary<>();
        for (Map.Entry<K, V> entry : dictionary.entrySet()) {
            cloned.put(entry.getKey(), entry.getValue());
        }
        return cloned;
    }
}