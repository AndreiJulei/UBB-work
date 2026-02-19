package model.adt;

import exceptions.MyException;

import java.util.HashMap;
import java.util.Map;

public class MyHeap<V> implements MyIHeap<V> {

    private Map<Integer, V> heap;
    private int nextFree = 1;

    public MyHeap() {
        heap = new HashMap<>();
    }

    @Override
    public int allocate(V value) {
        heap.put(nextFree, value);
        return nextFree++;
    }

    @Override
    public V get(int address) throws MyException {
        if (!heap.containsKey(address))
            throw new MyException("Invalid heap address: " + address);
        return heap.get(address);
    }

    @Override
    public void put(int address, V value) {
        heap.put(address, value);
    }

    @Override
    public boolean contains(int address) {
        return heap.containsKey(address);
    }

    @Override
    public void remove(int address) {
        heap.remove(address);
    }

    @Override
    public Map<Integer, V> getContent() {
        return heap;
    }

    @Override
    public void setContent(Map<Integer, V> newContent) {
        heap = newContent;
    }

    @Override
    public String toString() {
        return heap.toString();
    }
}
