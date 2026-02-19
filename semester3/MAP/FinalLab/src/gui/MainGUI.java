package gui;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import model.statements.IStmt;
import model.statements.CompStmt;
import model.statements.VarDeclStmt;
import model.statements.AssignStmt;
import model.statements.PrintStmt;
import model.statements.IfStmt;
import model.statements.OpenRFileStmt;
import model.statements.ReadFileStmt;
import model.statements.CloseRFileStmt;
import model.statements.WhileStmt;
import model.statements.NewStmt;
import model.statements.WriteHeapStmt;
import model.statements.ForkStmt;
import model.expressions.ValueExp;
import model.expressions.VarExp;
import model.expressions.ArithExp;
import model.expressions.RelationalExp;
import model.expressions.ReadHeapExp;
import model.expressions.LogicExp;
import model.types.IntType;
import model.types.BoolType;
import model.types.StringType;
import model.types.RefType;
import model.values.IntValue;
import model.values.BoolValue;
import model.values.StringValue;

import java.util.ArrayList;
import java.util.List;


public class MainGUI extends Application{
    @Override
    public void start(Stage primaryStage) throws Exception{
        // 1. load program executor first
        FXMLLoader mainLoader = new FXMLLoader(getClass().getResource("/gui/MainWindow.fxml"));
        Parent mainRoot = mainLoader.load();
        MainWindowController mainWindowController = mainLoader.getController();
        
        Scene mainScene = new Scene(mainRoot); 
        Stage mainStage = new Stage();
        mainStage.setTitle("Toy Language - Execution Dashboard");
        mainStage.setScene(mainScene);
        // dont show it right away, it is opened only when a program is selected

        // 2. load program chooser
        FXMLLoader selectLoader = new FXMLLoader(getClass().getResource("/gui/SelectWindow.fxml"));
        Parent selectRoot = selectLoader.load();
        SelectWindowController selectWindowController = selectLoader.getController();

        // 3. Link controllers 
        selectWindowController.setMainWindowController(mainWindowController);
        selectWindowController.setPrograms(getExampleList());

        // 4. Setup selection stage
        primaryStage.setTitle("Select a Program");
        primaryStage.setScene(new Scene(selectRoot));
        primaryStage.show();

        // Show main stage when a program is selected
        selectWindowController.setOnProgramSelect(() -> mainStage.show());
    }
    // Helper to get your existing programs from Interpreter.java
    private List<IStmt> getExampleList() {
        List<IStmt> list = new ArrayList<>();
        
        // Example 1: Simple assignment and print
        IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), 
                new PrintStmt(new VarExp("v"))));
        list.add(ex1);
        
        // Example 2: Arithmetic operations
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
        list.add(ex2);
        
        // Example 3: If statement
        IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(
                                        new IfStmt(new VarExp("a"), 
                                                new AssignStmt("v", new ValueExp(new IntValue(2))),
                                                new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                        new PrintStmt(new VarExp("v"))))));
        list.add(ex3);
        
        // Example 4: File operations
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
        list.add(ex4);
        
        // Example 5: Relational operations
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
        list.add(ex5);
        
        // Example 6: While loop - count down from 5 to 1
        IStmt ex6 = new CompStmt(
                new VarDeclStmt("n", new IntType()),
                new CompStmt(
                        new AssignStmt("n", new ValueExp(new IntValue(5))),
                        new WhileStmt(
                                new RelationalExp(">", new VarExp("n"), new ValueExp(new IntValue(0))),
                                new CompStmt(
                                        new PrintStmt(new VarExp("n")),
                                        new AssignStmt("n", new ArithExp('-', new VarExp("n"), new ValueExp(new IntValue(1))))
                                )
                        )
                )
        );
        list.add(ex6);
        
        // Example 7: Heap operations (new, write, read)
        IStmt ex7 = new CompStmt(
                new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                                new CompStmt(
                                        new WriteHeapStmt("v", new ValueExp(new IntValue(30))),
                                        new PrintStmt(new ReadHeapExp(new VarExp("v")))
                                )
                        )
                )
        );
        list.add(ex7);
        
        // Example 8: Logic operations (AND, OR)
        IStmt ex8 = new CompStmt(
                new VarDeclStmt("a", new BoolType()),
                new CompStmt(
                        new VarDeclStmt("b", new BoolType()),
                        new CompStmt(
                                new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(
                                        new AssignStmt("b", new ValueExp(new BoolValue(false))),
                                        new CompStmt(
                                                new PrintStmt(new LogicExp("&&", new VarExp("a"), new VarExp("b"))),
                                                new PrintStmt(new LogicExp("||", new VarExp("a"), new VarExp("b")))
                                        )
                                )
                        )
                )
        );
        list.add(ex8);
        
        // Example 9: Nested if statements
        IStmt ex9 = new CompStmt(
                new VarDeclStmt("x", new IntType()),
                new CompStmt(
                        new VarDeclStmt("y", new IntType()),
                        new CompStmt(
                                new AssignStmt("x", new ValueExp(new IntValue(10))),
                                new IfStmt(
                                        new RelationalExp(">", new VarExp("x"), new ValueExp(new IntValue(5))),
                                        new CompStmt(
                                                new AssignStmt("y", new ValueExp(new IntValue(100))),
                                                new PrintStmt(new VarExp("y"))
                                        ),
                                        new CompStmt(
                                                new AssignStmt("y", new ValueExp(new IntValue(50))),
                                                new PrintStmt(new VarExp("y"))
                                        )
                                )
                        )
                )
        );
        list.add(ex9);
        
        // Example 10: Arithmetic with multiple operations
        IStmt ex10 = new CompStmt(
                new VarDeclStmt("result", new IntType()),
                new CompStmt(
                        new AssignStmt("result", 
                                new ArithExp('+', 
                                        new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(4))),
                                        new ArithExp('/', new ValueExp(new IntValue(8)), new ValueExp(new IntValue(2)))
                                )),
                        new PrintStmt(new VarExp("result"))
                )
        );
        list.add(ex10);
        
        // Example 11: Fork statement (multi-threaded execution)
        IStmt ex11 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(0))),
                        new CompStmt(
                                new ForkStmt(
                                        new CompStmt(
                                                new AssignStmt("v", new ValueExp(new IntValue(1))),
                                                new PrintStmt(new VarExp("v"))
                                        )
                                ),
                                new CompStmt(
                                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                                        new PrintStmt(new VarExp("v"))
                                )
                        )
                )
        );
        list.add(ex11);
        
        // Example 12: Complex heap example with multiple references
        IStmt ex12 = new CompStmt(
                new VarDeclStmt("a", new RefType(new IntType())),
                new CompStmt(
                        new VarDeclStmt("b", new RefType(new IntType())),
                        new CompStmt(
                                new NewStmt("a", new ValueExp(new IntValue(5))),
                                new CompStmt(
                                        new NewStmt("b", new ValueExp(new IntValue(10))),
                                        new CompStmt(
                                                new PrintStmt(new ReadHeapExp(new VarExp("a"))),
                                                new CompStmt(
                                                        new PrintStmt(new ReadHeapExp(new VarExp("b"))),
                                                        new CompStmt(
                                                                new WriteHeapStmt("a", new ArithExp('+', new ReadHeapExp(new VarExp("a")), new ReadHeapExp(new VarExp("b")))),
                                                                new PrintStmt(new ReadHeapExp(new VarExp("a")))
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );
        list.add(ex12);
        
        return list;
    }

    public static void main(String[] args) {
        launch(args);
    }

}   
