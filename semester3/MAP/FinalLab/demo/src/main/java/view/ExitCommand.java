package view;

public class ExitCommand extends Command {
    public ExitCommand(String key, String desc) {
        super(key, desc);
    }

    @Override
    public void execute() {
        System.out.println("Exiting application...");
        System.exit(0); 
    }
}