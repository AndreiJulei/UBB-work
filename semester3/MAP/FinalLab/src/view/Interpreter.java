package view;

import controller.Controller;
import exceptions.MyException;
import model.PrgState;
import model.adt.MyIDictionary;
import model.adt.MyIList;
import model.adt.MyIStack;
import model.adt.MyDictionary;
import model.adt.MyList;
import model.adt.MyStack;
import model.expressions.ArithExp;
import model.expressions.ValueExp;
import model.expressions.VarExp;
import model.statements.*;
import model.types.BoolType;
import model.types.IntType;
import model.types.StringType;
import model.types.RefType;
import model.types.Type; // Import Type for the type checker
import model.values.BoolValue;
import model.values.IntValue;
import model.values.StringValue;
import model.values.RefValue;
import model.expressions.RelationalExp;
import model.expressions.ReadHeapExp;
import model.adt.MyHeap;
import repository.IRepository;
import repository.Repository;

import java.io.BufferedReader;
import java.util.ArrayList; // Used for a cleaner list of controllers
import java.util.List;

public class Interpreter {

    private static void runProgram(IStmt example, String logPath, String description, TextMenu menu, String key) {
        try {
            // 1. Define initial type environment (empty dictionary)
            MyIDictionary<String, Type> initialTypeEnv = new MyDictionary<>();
            
            // 2. Run the type checker on the starting statement (Required) 
            // If this throws an exception, the catch block is executed.
            example.typecheck(initialTypeEnv);

            // 3. If typecheck passes, proceed with creating PrgState (Required) 
            PrgState prg = new PrgState(
                new MyStack<IStmt>(), 
                new MyDictionary<String, model.values.Value>(), 
                new MyList<model.values.Value>(), 
                new MyDictionary<StringValue, BufferedReader>(), 
                new MyHeap<>(), 
                example
            );
            
            IRepository repo = new Repository(logPath);
            repo.addPrg(prg);
            Controller ctrl = new Controller(repo);

            // Add the command to the menu
            menu.addCommand(new RunExample(key, description, ctrl));

        } catch (MyException e) {
            // 4. If typecheck fails, display the error and do NOT create PrgState
            System.out.println("--- TYPE CHECK ERROR for Example " + key + " ---");
            System.out.println(description);
            System.out.println("Error: " + e.getMessage() + "\n");
        }
    }

    public static void main(String[] args) {
        
        // --- PROGRAM STATEMENTS ---

        IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("v"))));

        IStmt ex2 = new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()),
                        new CompStmt(
                                new AssignStmt("a",
                                        new ArithExp('+', new ValueExp(new IntValue(2)),
                                                new ArithExp('*', new ValueExp(new IntValue(3)),
                                                        new ValueExp(new IntValue(5))))),
                                new CompStmt(
                                        new AssignStmt("b",
                                                new ArithExp('+', new VarExp("a"), new ValueExp(new IntValue(1)))),
                                        new PrintStmt(new VarExp("b"))))));

        IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(
                                        new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new IntValue(2))),
                                                new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                        new PrintStmt(new VarExp("v"))))));
                
        IStmt ex4 = new CompStmt(
            new VarDeclStmt("varf", new StringType()),
            new CompStmt(   
                new AssignStmt("varf", new ValueExp(new StringValue("test.txt"))), 
                new CompStmt(
                    new OpenRFileStmt(new VarExp("varf")),
                    new CompStmt(
                        new VarDeclStmt("varc", new IntType()),
                        new CompStmt(
                            new ReadFileStmt(new VarExp("varf"), "varc"),
                            new CompStmt(
                                new PrintStmt(new VarExp("varc")),
                                new CompStmt(
                                    new ReadFileStmt(new VarExp("varf"), "varc"),
                                    new CompStmt(
                                        new PrintStmt(new VarExp("varc")),
                                        new CloseRFileStmt(new VarExp("varf"))
                                    )
                                )
                            )
                        )
                    )
                )
            )
        );

        IStmt ex5 = new CompStmt(
                new VarDeclStmt("a", new IntType()),
                    new CompStmt(
                        new VarDeclStmt("b", new IntType()),
                        new CompStmt(
                            new AssignStmt("a", new ValueExp(new IntValue(5))),
                            new CompStmt(
                                new AssignStmt("b", new ValueExp(new IntValue(3))),
                                new CompStmt(
                                    new PrintStmt(new RelationalExp(">", new VarExp("a"), new VarExp("b"))),
                                    new PrintStmt(new RelationalExp("<=", new VarExp("a"), new VarExp("b")))
                                )
                            )
                        )
                    )
                );
        
        IStmt ex6 = new CompStmt(
            new VarDeclStmt("file1", new StringType()),
            new CompStmt(
                new VarDeclStmt("file2", new StringType()),
                new CompStmt(
                    new AssignStmt("file1", new ValueExp(new StringValue("test.txt"))),
                    new CompStmt(
                        new AssignStmt("file2", new ValueExp(new StringValue("test2.txt"))), 
                        new CompStmt(
                            new OpenRFileStmt(new VarExp("file1")),
                            new CompStmt(
                                new OpenRFileStmt(new VarExp("file2")),
                                new CompStmt(
                                    new VarDeclStmt("val", new IntType()),
                                    new CompStmt(
                                        new ReadFileStmt(new VarExp("file1"), "val"),
                                        new CompStmt(
                                            new PrintStmt(new VarExp("val")),
                                            new CompStmt(
                                                new ReadFileStmt(new VarExp("file2"), "val"),
                                                new CompStmt(
                                                    new PrintStmt(new VarExp("val")),
                                                    new CompStmt(
                                                        new CloseRFileStmt(new VarExp("file1")),
                                                        new CloseRFileStmt(new VarExp("file2"))
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        );
        
        IStmt ex7 = new CompStmt(   
            new VarDeclStmt("v", new IntType()),
            new CompStmt(
                new AssignStmt("v", new ValueExp(new IntValue(4))),
                new CompStmt(
                    new WhileStmt(
                        new RelationalExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                        new CompStmt(
                            new PrintStmt(new VarExp("v")),
                            new AssignStmt("v", new ArithExp('-', new VarExp("v"), new ValueExp(new IntValue(1))))
                        )
                    ),
                    new PrintStmt(new VarExp("v"))
                )
            )
        );

        IStmt ex9 = new CompStmt(
            new VarDeclStmt("v", new RefType(new IntType())),
            new CompStmt(
                new NewStmt("v", new ValueExp(new IntValue(20))),
                new CompStmt(
                    new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                    new CompStmt(
                        new NewStmt("a", new VarExp("v")),
                        new CompStmt(
                            new PrintStmt(new VarExp("v")),
                            new PrintStmt(new VarExp("a"))
                        )
                    )
                )
            )
        );

        IStmt ex10 = new CompStmt(
            new VarDeclStmt("v", new RefType(new IntType())),
            new CompStmt(
                new NewStmt("v", new ValueExp(new IntValue(20))),
                new CompStmt(
                    new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                    new CompStmt(
                        new NewStmt("a", new VarExp("v")),
                        new CompStmt(
                            new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                            new PrintStmt(new ArithExp('+', new ReadHeapExp(new ReadHeapExp(new VarExp("a"))), new ValueExp(new IntValue(5))))
                        )
                    )
                )
            )
        );

        IStmt ex11 = new CompStmt(
            new VarDeclStmt("v", new RefType(new IntType())),
            new CompStmt(
                new NewStmt("v", new ValueExp(new IntValue(20))),
                new CompStmt(
                    new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                    new CompStmt(
                        new WriteHeapStmt("v", new ValueExp(new IntValue(30))),
                        new PrintStmt(new ArithExp('+', new ReadHeapExp(new VarExp("v")), new ValueExp(new IntValue(5))))
                    )
                )
            )
        );

        IStmt ex12 = new CompStmt(
            new VarDeclStmt("v", new RefType(new IntType())),
            new CompStmt(
                new NewStmt("v", new ValueExp(new IntValue(20))),
                new CompStmt(
                    new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                    new CompStmt(
                        new NewStmt("a", new VarExp("v")),
                        new CompStmt(
                            new NewStmt("v", new ValueExp(new IntValue(30))),
                            new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a"))))
                        )
                    )
                )
            )
        );

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

        // --- MENU SETUP ---
        
        TextMenu menu = new TextMenu();
        
        menu.addCommand(new ExitCommand("0", "Exit the interpreter"));
        
        // --- ADDING EXAMPLES WITH TYPE CHECK ---
        
        runProgram(ex1, "log1.txt", "int v; v=2; Print(v)", menu, "1");
        runProgram(ex2, "log2.txt", "Arithmetic: int a; int b; a=2+3*5; b=a+1; Print(b)", menu, "2");
        runProgram(ex3, "log3.txt", "Conditional: bool a; int v; a=true; (If a Then v=2 Else v=3); Print(v)", menu, "3");
        runProgram(ex4, "log4_file_read.txt", "File Ops: Open('test.txt'), read 2 ints, print them, close file", menu, "4");
        runProgram(ex5, "log5_relational.txt", "Relational Exp: Print(5 > 3) and Print(5 <= 3)", menu, "5");
        runProgram(ex6, "log6_multi_file.txt", "Multi-file Operations: Open two files ('test.txt', 'test2.txt'), read one value from each, print them, close both.", menu, "6");
        runProgram(ex7, "log7_while.txt", "While Loop: int v; v=4; (while (v>0) Print(v);v=v-1);Print(v)", menu, "7");
        runProgram(ex9, "log9_refrefint.txt", "Ref int v;new(v,20);Ref Ref int a; new(a,v);print(v);print(a)", menu, "9");
        runProgram(ex10, "log10_refrefint_rh.txt", "Ref int v;new(v,20);Ref Ref int a; new(a,v);print(rH(v));print(rH(rH(a))+5)", menu, "10");
        runProgram(ex11, "log11_rh_wh.txt", "Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);", menu, "11");
        runProgram(ex12, "log12_nested_rh.txt", "Nested rH: Ref int v;new(v,20);Ref Ref int a; new(a,v); new(v,30);print(rH(rH(a)))", menu, "12");
        runProgram(ex13, "log13_fork_shared_heap.txt", "Fork with shared heap: int v; Ref int a; v=10;new(a,22); fork(wH(a,30);v=32;print(v);print(rH(a))); print(v);print(rH(a))", menu, "13");
        
        menu.show();
    }
}