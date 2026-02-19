package repository;

import exceptions.LanguageInterpreterException;
import model.state.ProgramState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Repository implements IRepository {
    private final List<ProgramState> programStates = new ArrayList<>();
    private final String logFilePath;

    public Repository(ProgramState initialProgram, String logFilePath) {
        programStates.add(initialProgram);
        this.logFilePath = logFilePath;
    }

    @Override
    public void logPrgStateExec(ProgramState programState) throws LanguageInterpreterException {
        try(var logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)))) {
            logFile.println(programState.toString());
            logFile.flush();
        }
        catch (IOException e) {
            throw new LanguageInterpreterException(e.getMessage());
        }
    }

    @Override
    public List<ProgramState> getProgramsList() {
        return List.copyOf(programStates);
    }

    @Override
    public void setProgramsList(List<ProgramState> programsList) {
        programStates.clear();
        programStates.addAll(programsList);
    }

}
