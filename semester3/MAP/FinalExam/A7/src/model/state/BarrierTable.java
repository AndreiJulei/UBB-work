package model.state;
import javafx.util.Pair;
import model.adt.IBarrierTable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class BarrierTable implements IBarrierTable {
    private final Map<Integer, Pair<Integer, List<Integer>>> content;
    private int freeLocation;
    private final Lock lock;

    public BarrierTable(){
        this.content = new HashMap<>();
        this.freeLocation = 0;
        this.lock = new ReentrantLock();
    }

    private int getFreeAddress() {
        while (content.containsKey(freeLocation)) {
            freeLocation++;
        }
        return freeLocation;
    }
    
    @Override
    public int allocate(int capacity){
        lock.lock();
        try{
            int address = getFreeAddress();
            content.put(address, new Pair <>(capacity, new ArrayList<>()));
            freeLocation++;
            return address;
        } finally {
            lock.unlock();
        }
    }

    @Override
    public Pair<Integer, List<Integer>> get(int address) {
        lock.lock();
        try {
            return content.get(address);
        } finally {
            lock.unlock();
        }
    }

    @Override
    public void put(int address, Pair <Integer, List<Integer>> value){
        lock.lock();
        try{
            content.put(address,value);
        } finally{
            lock.unlock();
        }
    }

    @Override
    public Map<Integer, Pair<Integer, List<Integer>>> getAll() {
        lock.lock();
        try {
            return new HashMap<>(content);
        } finally {
            lock.unlock();
        }
    }

    @Override
    public boolean isDefined(int address){
        lock.lock();
        try{
            return content.containsKey(address);
        } finally {
            lock.unlock();
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        for (var entry : content.entrySet()) {
            sb.append(entry.getKey())
              .append(" -> (")
              .append(entry.getValue().getKey())
              .append(", ")
              .append(entry.getValue().getValue())
              .append("), ");
        }
        if (!content.isEmpty()) {
            sb.setLength(sb.length() - 2);
        }
        sb.append("}");
        return sb.toString();
    }
}
