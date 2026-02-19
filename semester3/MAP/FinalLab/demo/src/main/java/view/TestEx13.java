package view;

import controller.Controller;
import exceptions.MyException;
import model.PrgState;
import model.adt.*;
import model.expressions.*;
import model.statements.*;
import model.types.*;
import model.values.*;
import repository.IRepository;
import repository.Repository;

import java.io.BufferedReader;

public class TestEx13 {
    public static void main(String[] args) {
        // Example 13: Fork with shared heap
        IStmt ex13 = new CompStmt(
            new VarDeclStmt("v", new IntType()),
            new CompStmt(
                new VarDeclStmt("a", new RefType(new IntType())),
                new CompStmt(
                    new AssignStmt("v", new ValueExp(new IntValue(10))),
                    new CompStmt(
                        new NewStmt("a", new ValueExp(new IntValue(22))),
                        new CompStmt(
                            new ForkStmt(
                                new CompStmt(
                                    new WriteHeapStmt("a", new ValueExp(new IntValue(30))),
                                    new CompStmt(
                                        new AssignStmt("v", new ValueExp(new IntValue(32))),
                                        new CompStmt(
                                            new PrintStmt(new VarExp("v")),
                                            new PrintStmt(new ReadHeapExp(new VarExp("a")))
                                        )
                                    )
                                )
                            ),
                            new CompStmt(
                                new PrintStmt(new VarExp("v")),
                                new PrintStmt(new ReadHeapExp(new VarExp("a")))
                            )
                        )
                    )
                )
            )
        );

        PrgState prg13 = new PrgState(
            new MyStack<IStmt>(),
            new MyDictionary<String, model.values.Value>(),
            new MyList<model.values.Value>(),
            new MyDictionary<StringValue, BufferedReader>(),
            new MyHeap<>(),
            ex13
        );

        IRepository repo13 = new Repository("log13_test.txt");
        repo13.addPrg(prg13);
        Controller ctrl13 = new Controller(repo13);

        try {
            ctrl13.allStep();
            System.out.println("Execution completed successfully!");
            System.out.println("Final output: " + prg13.getOut());
            System.out.println("Final heap: " + prg13.getHeap());
        } catch (MyException e) {
            System.out.println("Runtime Error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Fatal Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
