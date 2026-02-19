package view.gui;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import model.expression.*;
import model.state.Out;
import model.statement.*;
import model.type.*;
import model.value.BooleanValue;
import model.value.IntegerValue;
import model.value.StringValue;

import java.util.List;

public class MainApp extends Application {

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage stage) throws Exception {

        // ================= EXAMPLES =================

        /* Program #1
         * int v
         * v = 2
         * print(v)
         */
        IStatement ex1 = new CompoundStatement(
                new VariableDeclarationStatement(new IntegerType(), "v"),
                new CompoundStatement(
                        new AssignmentStatement(new ConstantExpression(new IntegerValue(2)), "v"),
                        new PrintStatement(new VariableExpression("v"))
                )
        );

        /* Program #2
         * int a
         * int b
         * a=2+3*5
         * b=a+1
         * print(b)
         */
        IStatement ex2 = new CompoundStatement(
                new VariableDeclarationStatement(new IntegerType(), "a"),
                new CompoundStatement(
                        new VariableDeclarationStatement(new IntegerType(), "b"),
                        new CompoundStatement(
                                new AssignmentStatement(new ArithmeticExpression("+",
                                        new ConstantExpression(new IntegerValue(2)),
                                        new ArithmeticExpression("*",
                                                new ConstantExpression(new IntegerValue(3)),
                                                new ConstantExpression(new IntegerValue(5))
                                        )
                                ), "a"),
                                new CompoundStatement(
                                        new AssignmentStatement(new ArithmeticExpression("+",
                                                new VariableExpression("a"),
                                                new ConstantExpression(new IntegerValue(1))
                                        ), "b"),
                                        new PrintStatement(new VariableExpression("b"))
                                )
                        )
                )
        );

        /* Program #3
         * bool a
         * int v
         * a = true
         * if a then v=2
         * else v=3
         * print(v)
         */
        IStatement ex3 = new CompoundStatement(
                new VariableDeclarationStatement(new BooleanType(), "a"),
                new CompoundStatement(
                        new VariableDeclarationStatement(new IntegerType(), "v"),
                        new CompoundStatement(
                                new AssignmentStatement(new ConstantExpression(new BooleanValue(true)), "a"),
                                new CompoundStatement(
                                        new IfStatement(
                                                new VariableExpression("a"),
                                                new AssignmentStatement(new ConstantExpression(new IntegerValue(2)), "v"),
                                                new AssignmentStatement(new ConstantExpression(new IntegerValue(3)), "v")
                                        ),
                                        new PrintStatement(new VariableExpression("v"))
                                )
                        )
                )
        );

        /*
         * string s;
         * s="test.in";
         * openRFile(s);
         * int a;
         * readFile(s,a);print(a);
         * readFile(s,a);print(a)
         * closeRFile(s)
         */

        IStatement ex4 = new CompoundStatement(
                new VariableDeclarationStatement(new StringType(), "s"),
                new CompoundStatement(
                        new AssignmentStatement(new ConstantExpression(new StringValue("test.in")), "s"),
                        new CompoundStatement(
                                new OpenRFileStatement(new VariableExpression("s")),
                                new CompoundStatement(
                                        new VariableDeclarationStatement(new IntegerType(), "a"),
                                        new CompoundStatement(
                                                new ReadFileStatement(new VariableExpression("s"), "a"),
                                                new CompoundStatement(
                                                        new PrintStatement(new VariableExpression("a")),
                                                        new CompoundStatement(
                                                                new ReadFileStatement(new VariableExpression("s"), "a"),
                                                                new CompoundStatement(
                                                                        new PrintStatement(new VariableExpression("a")),
                                                                        new CloseRFileStatement(new VariableExpression("s"))
                                                                )
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        /*
         * int a
         * int b
         * int c
         * a = 3
         * b = 5
         * if a < b
         * then
         * c = 1
         * else
         * c = 2
         * print c
         */
        IStatement ex5 = new CompoundStatement(
                new VariableDeclarationStatement(new IntegerType(), "a"),
                new CompoundStatement(
                        new VariableDeclarationStatement(new IntegerType(), "b"),
                        new CompoundStatement(
                                new VariableDeclarationStatement(new IntegerType(), "c"),
                                new CompoundStatement(
                                        new AssignmentStatement(new ConstantExpression(new IntegerValue(3)), "a"),
                                        new CompoundStatement(
                                                new AssignmentStatement(new ConstantExpression(new IntegerValue(5)), "b"),
                                                new CompoundStatement(
                                                        new IfStatement(new RelationalExpression("<", new VariableExpression("a"), new VariableExpression("b")),
                                                                new AssignmentStatement(new ConstantExpression(new IntegerValue(1)), "c"),
                                                                new AssignmentStatement(new ConstantExpression(new IntegerValue(2)), "c")
                                                        ),
                                                        new PrintStatement(new VariableExpression("c"))
                                                )
                                        )
                                )
                        )
                )
        );

        // Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);
        IStatement ex6 = new CompoundStatement(
                new VariableDeclarationStatement(new ReferenceType(new IntegerType()), "v"),
                new CompoundStatement(
                        new HeapAllocationStatement("v", new ConstantExpression(new IntegerValue(20))),
                        new CompoundStatement(
                                new PrintStatement(new HeapReadingExpression(new VariableExpression("v"))),
                                new CompoundStatement(
                                        new HeapWritingStatement("v", new ConstantExpression(new IntegerValue(30))),
                                        new PrintStatement(new ArithmeticExpression(
                                                "+",
                                                new HeapReadingExpression(new VariableExpression("v")),
                                                new ConstantExpression(new IntegerValue(5))
                                        ))
                                )
                        )
                )
        );

        // Ref int v;new(v,20);Ref Ref int a; new(a,v); new(v,30);print(rH(rH(a)))
        IStatement ex7 = new CompoundStatement(
                new VariableDeclarationStatement(new ReferenceType(new IntegerType()), "v"),
                new CompoundStatement(
                        new HeapAllocationStatement("v", new ConstantExpression(new IntegerValue(20))),
                        new CompoundStatement(
                                new VariableDeclarationStatement(new ReferenceType(new ReferenceType(new IntegerType())), "a"),
                                new CompoundStatement(
                                        new HeapAllocationStatement("a", new VariableExpression("v")),
                                        new CompoundStatement(
                                                new HeapAllocationStatement("v", new ConstantExpression(new IntegerValue(30))),
                                                new CompoundStatement(
                                                        new PrintStatement(new HeapReadingExpression(new HeapReadingExpression(new VariableExpression("a")))),
                                                        new CompoundStatement(
                                                                new HeapWritingStatement("a", new VariableExpression("v")),
                                                                new PrintStatement(new HeapReadingExpression(new HeapReadingExpression(new VariableExpression("a"))))
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // int v; v=4; (while (v>0) print(v);v=v-1);print(v)
        IStatement ex8 = new CompoundStatement(
                new VariableDeclarationStatement(new IntegerType(), "v"),
                new CompoundStatement(
                        new AssignmentStatement(new ConstantExpression(new IntegerValue(4)), "v"),
                        new CompoundStatement(
                                new WhileStatement(
                                        new RelationalExpression(">", new VariableExpression("v"), new ConstantExpression(new IntegerValue(0))),
                                        new CompoundStatement(
                                                new PrintStatement(new VariableExpression("v")),
                                                new AssignmentStatement(new ArithmeticExpression("-", new VariableExpression("v"), new ConstantExpression(new IntegerValue(1))), "v")
                                        )
                                ),
                                new PrintStatement(new VariableExpression("v"))
                        )
                )
        );

        // int v; Ref int a; v=10;new(a,22);
        // fork(wH(a,30);v=32;print(v);print(rH(a)));
        // print(v);print(rH(a))
        IStatement ex9 = new CompoundStatement(
                new VariableDeclarationStatement(new IntegerType(), "v"),
                new CompoundStatement(
                        new VariableDeclarationStatement(new ReferenceType(new IntegerType()), "a"),
                        new CompoundStatement(
                                new AssignmentStatement(new ConstantExpression(new IntegerValue(10)), "v"),
                                new CompoundStatement(
                                        new HeapAllocationStatement("a", new ConstantExpression(new IntegerValue(22))),
                                        new CompoundStatement(
                                                new ForkStatement(
                                                        new CompoundStatement(
                                                                new HeapWritingStatement("a", new ConstantExpression(new IntegerValue(30))),
                                                                new CompoundStatement(
                                                                        new AssignmentStatement(new ConstantExpression(new IntegerValue(32)), "v"),
                                                                        new CompoundStatement(
                                                                                new PrintStatement(new VariableExpression("v")),
                                                                                new PrintStatement(new HeapReadingExpression(new VariableExpression("a")))
                                                                        )
                                                                )
                                                        )
                                                ),
                                                new CompoundStatement(
                                                        new PrintStatement(new VariableExpression("v")),
                                                        new PrintStatement(new HeapReadingExpression(new VariableExpression("a")))
                                                )
                                        )
                                )
                        )
                )
        );
        /** 
        The following program must be hard coded in your implementation:
        int v; int x; v=3;x=2;
        (repeat (fork(print(v);x=x-1;print(x));v=v+1) as v==0);
        nop;nop;nop;nop;nop;nop;nop;
        print(x)
        The final Out should be {3,1,2} */
        IStatement ex10 = new CompoundStatement(
                new VariableDeclarationStatement(new IntegerType(), "v"),
                new CompoundStatement(
                        new VariableDeclarationStatement(new IntegerType(), "x"),
                        new CompoundStatement(
                                new AssignmentStatement(new ConstantExpression(new IntegerValue(3)), "v"),
                                new CompoundStatement(
                                        new AssignmentStatement(new ConstantExpression(new IntegerValue(2)), "x"),
                                        new CompoundStatement(
                                                new RepeatUntilStatement(
                                                        new CompoundStatement(
                                                                new ForkStatement(
                                                                        new CompoundStatement(
                                                                                new PrintStatement(new VariableExpression("v")),
                                                                                new CompoundStatement(
                                                                                        new AssignmentStatement(
                                                                                                new ArithmeticExpression("-",
                                                                                                        new VariableExpression("x"),
                                                                                                        new ConstantExpression(new IntegerValue(1))
                                                                                                ),
                                                                                                "x"
                                                                                        ),
                                                                                        new PrintStatement(new VariableExpression("x"))
                                                                                )
                                                                        )
                                                                ),
                                                                new AssignmentStatement(
                                                                        new ArithmeticExpression("+",
                                                                                new VariableExpression("v"),
                                                                                new ConstantExpression(new IntegerValue(1))
                                                                        ),
                                                                        "v"
                                                                )
                                                        ),
                                                        new RelationalExpression("==",
                                                                new VariableExpression("v"),
                                                                new ConstantExpression(new IntegerValue(0))
                                                        )
                                                ),
                                                new CompoundStatement(
                                                        new NoOperationStatement(),
                                                        new CompoundStatement(
                                                                new NoOperationStatement(),
                                                                new CompoundStatement(
                                                                        new NoOperationStatement(),
                                                                        new CompoundStatement(
                                                                                new NoOperationStatement(),
                                                                                new CompoundStatement(
                                                                                        new NoOperationStatement(),
                                                                                        new CompoundStatement(
                                                                                                new NoOperationStatement(),
                                                                                                new CompoundStatement(
                                                                                                        new NoOperationStatement(),
                                                                                                        new PrintStatement(new VariableExpression("x"))
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

        List<IStatement> programs = List.of(
                ex1, ex2, ex3, ex4, ex5, ex6, ex7, ex8, ex9, ex10
        );

        // ================= GUI =================

        FXMLLoader loader = new FXMLLoader(
                getClass().getResource("ProgramSelectorView.fxml")
        );
        Scene scene = new Scene(loader.load());

        ProgramSelectorController controller = loader.getController();
        controller.setPrograms(programs);

        stage.setTitle("Select Program");
        stage.setScene(scene);
        stage.show();
    }
}
