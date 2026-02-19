package view.gui;

import controller.Controller;
import exceptions.LanguageInterpreterException;
import model.state.ProgramState;

import java.util.List;

public class PrgStateService {

    private final Controller controller;

    public PrgStateService(Controller controller) {
        this.controller = controller;
    }

    public void oneStep() {
        try {
            List<ProgramState> active =
                    controller.removeCompletedPrograms(controller.getProgramsList());

            if (active.isEmpty()) {
                return;
            }

            controller.oneStepForAll(active);

        } catch (Exception e) {
            throw new LanguageInterpreterException(e.getMessage());
        }
    }

    public List<ProgramState> getPrograms() {
        return controller.getProgramsList();
    }
}
    