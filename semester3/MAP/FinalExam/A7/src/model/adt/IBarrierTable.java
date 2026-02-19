package model.adt;

import javafx.util.Pair;

import java.util.List;
import java.util.Map;


public interface IBarrierTable {
    int allocate(int capacity);
    Pair <Integer, List<Integer>> get(int address);
    void put(int address, Pair<Integer, List<Integer>> value);
    boolean isDefined(int address);
    Map<Integer, Pair<Integer, List<Integer>>> getAll();
}
