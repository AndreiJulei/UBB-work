package model.statements;

import model.expressions.Exp;
import model.expressions.RelationalExp;  
import model.expressions.VarExp;
import model.PrgState;
import exceptions.MyException;
import model.values.Value;
import model.types.Type;
import model.types.IntType;

import model.adt.MyIDictionary;

public class ForStmt implements IStmt {
    private String v;
    private Exp exp1;
    private Exp exp2;
    private Exp exp3;
    private IStmt stmt;

    public ForStmt(String v, Exp exp1, Exp exp2, Exp exp3, IStmt stmt) {
        this.v = v;
        this.exp1 = exp1;
        this.exp2 = exp2;
        this.exp3 = exp3;
        this.stmt = stmt;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        // Transformation rule: for(v=exp1; v<exp2; v=exp3) stmt
        // Becomes: int v; v=exp1; while(v<exp2) {stmt; v=exp3}
        IStmt converted = new CompStmt(
            new VarDeclStmt(v, new IntType()),
            new CompStmt(
                new AssignStmt(v, exp1),
                new WhileStmt(
                    new RelationalExp("<", new VarExp(v), exp2),
                    new CompStmt(stmt, new AssignStmt(v, exp3))
                )
            )
        );

        state.getStk().push(converted); 
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        // 1. exp1 does not depend on v, so check it against the original environment
        Type type1 = exp1.typecheck(typeEnv);

        // 2. Create the inner environment where v exists (just like the runtime int v; declaration)
        MyIDictionary<String, Type> innerEnv = typeEnv.clone(); 
        innerEnv.put(v, new IntType()); 

        // 3. Now check exp2, exp3, and the body against the environment that HAS v
        Type type2 = exp2.typecheck(innerEnv); 
        Type type3 = exp3.typecheck(innerEnv);
        stmt.typecheck(innerEnv);

        // 4. Verify the required types for the expressions 
        if (type1.equals(new IntType()) && type2.equals(new IntType()) && type3.equals(new IntType())) {
            return typeEnv;
        } else {
            throw new MyException("For statement: expressions must be of type int.");
        }
    }

    @Override
    public String toString() {
        return "for(" + v + "=" + exp1 + "; " + v + "<" + exp2 + "; " + v + "=" + exp3 + ") " + stmt;
    }
}