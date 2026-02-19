package gui;

import controller.Controller;
import exceptions.MyException;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import model.PrgState;
import model.adt.MyDictionary;
import model.adt.MyHeap;
import model.adt.MyList;
import model.adt.MyStack;
import model.statements.IStmt;
import model.types.Type;
import repository.Repository;

import java.util.ArrayList;
import java.util.List;

public class SelectWindowController {
    private MainWindowController mainWindowController;

    @FXML private ListView<IStmt> programListView;
    @FXML private Button selectButton;
    private Runnable onProgramSelect;

    public void setMainWindowController(MainWindowController mainWindowController){
        this.mainWindowController = mainWindowController;
    }

    public void setOnProgramSelect(Runnable callback) {
        this.onProgramSelect = callback;
    }

    public Button getSelectButton() {
        return selectButton;
    }

    @FXML
    public void initialize(){

    }

    public void setPrograms(List<IStmt> programs){
        programListView.setItems(FXCollections.observableArrayList(programs));
    }

    @FXML
    public void handleSelect(){
        IStmt selectedStmt = programListView.getSelectionModel().getSelectedItem();
        if (selectedStmt == null){
            showError("Please select a program!");
            return;
        }

        try{
            // run typecheck first
            selectedStmt.typecheck(new MyDictionary<String, Type>());
            
            //initialize prgState
            PrgState prg = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new MyDictionary<>(), new MyHeap<>(), selectedStmt);
            
            // Setup repository and controller
            Repository repo = new Repository("log_gui.txt");
            repo.addPrg(prg);
            Controller ctrl = new Controller(repo);

            mainWindowController.setController(ctrl);
            
            // Trigger callback to show main window
            if (onProgramSelect != null) {
                onProgramSelect.run();
            }
        } catch (MyException e){
            showError("Type Check Error: " + e.getMessage());
        }
    }

    public void showError(String message){
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Selection Error");
        alert.setContent(message);
        alert.showAndWait();
    }
}
