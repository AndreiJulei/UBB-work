package repository;

import exceptions.LanguageInterpreterException;
import model.state.ProgramState;

import java.util.List;

public interface IRepository {
    void logPrgStateExec(ProgramState programState) throws LanguageInterpreterException;
    List<ProgramState> getProgramsList();
    void setProgramsList(List<ProgramState> programsList);
}