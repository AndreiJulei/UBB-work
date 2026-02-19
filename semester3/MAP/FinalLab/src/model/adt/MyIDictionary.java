package model.adt;

import exceptions.MyException;
import java.util.Map;

public interface MyIDictionary<K, V> {
    boolean isDefined(K key);
    V lookup(K key) throws MyException;
    void update(K key, V value);
    void put(K key, V value);
    Map<K, V> getContent();
    MyIDictionary<K, V> clone();
}