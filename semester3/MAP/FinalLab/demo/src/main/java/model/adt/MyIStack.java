package model.adt;

import exceptions.MyException;

import java.util.List;

public interface MyIStack<T> {
    T pop() throws MyException;
    void push(T v);
    boolean isEmpty();
    List<T> getReversed();
}