package model;

import exceptions.MyException;
import model.adt.MyIDictionary;
import model.adt.MyIHeap;
import model.adt.MyIList;
import model.adt.MyIStack;
import model.statements.IStmt;
import model.values.StringValue;
import model.values.Value;

import java.io.BufferedReader;
import java.util.Map;

public class PrgState {
    private final MyIStack<IStmt> exeStack;
    private final MyIDictionary<String, Value> symTable;
    private final MyIList<Value> out;
    private final MyIDictionary<StringValue, BufferedReader> fileTable;
    private final MyIHeap<Value> heap;

    private final IStmt originalProgram;
    private final int id; 

    private static int lastId = 0;

    // Static synchronized method to manage the ID 
    private static synchronized int getNewId() {
        lastId++;
        return lastId;
    }

    // Main constructor 
    public PrgState(MyIStack<IStmt> stk,
                    MyIDictionary<String, Value> symtbl,
                    MyIList<Value> ot,
                    MyIDictionary<StringValue, BufferedReader> fileTable,
                    MyIHeap<Value> heap,
                    IStmt prg) {

        this.exeStack = stk;
        this.symTable = symtbl;
        this.out = ot;
        this.fileTable = fileTable;
        this.heap = heap;

        this.originalProgram = prg;
        this.id = getNewId(); 

        stk.push(prg);
    }

    // Constructor for forking
    public PrgState(MyIStack<IStmt> stk,
                    MyIDictionary<String, Value> symtbl,
                    MyIList<Value> ot,
                    MyIDictionary<StringValue, BufferedReader> fileTable,
                    MyIHeap<Value> heap) {

        this.exeStack = stk;
        this.symTable = symtbl;
        this.out = ot;
        this.fileTable = fileTable;
        this.heap = heap;

        this.originalProgram = null;
        this.id = getNewId(); 
    }

    public int getId() {
        return id;
    }

    // Returns true when exeStack is not empty, false otherwise
    public boolean isNotCompleted() {
        return !exeStack.isEmpty();
    }

    // oneStep method moved from Controller to PrgState 
    public PrgState oneStep() throws MyException {
        if (exeStack.isEmpty())
            throw new MyException("prgstate stack is empty"); 

        IStmt crtStmt = exeStack.pop(); 
        return crtStmt.execute(this); 
    }

    // Getters
    public MyIStack<IStmt> getStk() { return exeStack; }

    public MyIDictionary<String, Value> getSymTable() { return symTable; }

    public MyIList<Value> getOut() { return out; }

    public MyIDictionary<StringValue, BufferedReader> getFileTable() { return fileTable; }

    public MyIHeap<Value> getHeap() { return heap; }

    // Modified to print ID first 
    @Override
    public String toString() {
        return "Id=" + id + "\n" +
                "ExeStack:\n   " + exeStack.toString() + "\n" +
                "SymTable:\n   " + symTable.toString() + "\n" +
                "Out:\n   " + out.toString() + "\n" +
                "FileTable:\n   " + fileTable.toString() + "\n" +
                "Heap:\n   " + heap.toString() + "\n";
    }
}