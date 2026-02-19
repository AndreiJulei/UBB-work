package view;

import controller.Controller;
import exceptions.MyException;

public class RunExample extends Command {
    private Controller ctr; 

    public RunExample(String key, String desc, Controller ctr) {
        super(key, desc); 
        this.ctr = ctr; 
    }

    @Override 
    public void execute() {
        try {
            ctr.allStep();
        } catch (MyException e) {
            System.out.println("Runtime Error: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Fatal Error: " + e.getMessage());
        }
    }
}