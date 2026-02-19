package model.adt;

import exceptions.MyException;
import java.util.Map;

public interface ILockTable {
    int allocate(int value); 
    void update(int address, int value) throws MyException;
    int lookup(int address) throws MyException;
    boolean isDefined(int address);
    void setContent(Map<Integer, Integer> content);
    Map<Integer, Integer> getContent();
}