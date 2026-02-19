package repository;

import model.PrgState;
import exceptions.MyException;
import model.statements.IStmt;
import model.values.StringValue;
import model.values.Value;

import java.io.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.io.BufferedReader;

public class Repository implements IRepository {
    private List<PrgState> prgList;
    private final String logFilePath;

    public Repository(String logFilePath) {
        this.prgList = new ArrayList<>();
        this.logFilePath = logFilePath;
    }

    @Override
    public List<PrgState> getPrgList() { 
        return prgList; 
    }

    @Override
    public void setPrgList(List<PrgState> prgList) { 
        this.prgList = prgList; 
    }

    @Override
    public void addPrg(PrgState prg) { 
        prgList.add(prg); 
    }

    @Override
    public void logPrgStateExec(PrgState state) throws MyException {
        try (PrintWriter logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)))) {
            logFile.println("=== Program State (id=" + state.getId() + ") ===");
            logFile.println("ExeStack:");
            for (IStmt stmt : state.getStk().getReversed()) logFile.println("   " + stmt);
            logFile.println("SymTable:");
            for (Map.Entry<String, Value> e : state.getSymTable().getContent().entrySet())
                logFile.println("   " + e.getKey() + " -> " + e.getValue());
            logFile.println("Out:");
            for (Value v : state.getOut().getList()) logFile.println("   " + v);
            logFile.println("FileTable:");
            for (Map.Entry<StringValue, BufferedReader> e : state.getFileTable().getContent().entrySet())
                logFile.println("   " + e.getKey().getVal());
            logFile.println("Heap:");
            for (Map.Entry<Integer, Value> e : state.getHeap().getContent().entrySet())
                logFile.println("   " + e.getKey() + " -> " + e.getValue());
            logFile.println("==============================\n");
        } catch (IOException ex) {
            throw new MyException("Error writing to log file: " + ex.getMessage());
        }
    }
}
