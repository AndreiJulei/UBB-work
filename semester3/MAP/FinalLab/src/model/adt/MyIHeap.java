package model.adt;

import exceptions.MyException;
import java.util.Map;

public interface MyIHeap<V> {
    int allocate(V value);                      // returns new free address
    V get(int address) throws MyException;      // read from heap
    void put(int address, V value);             // write to heap
    boolean contains(int address);
    void remove(int address);
    Map<Integer, V> getContent();
    void setContent(Map<Integer, V> newContent);
}
