package repository;

import model.PrgState;

import model.PrgState;

import java.util.ArrayList;
import java.util.List;
import exceptions.MyException;
import java.io.PrintWriter;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public interface IRepository {
    List<PrgState> getPrgList();
 
    void setPrgList(List<PrgState> prgList);
 
    void addPrg(PrgState prg);
 
    void logPrgStateExec(PrgState state) throws MyException;
}