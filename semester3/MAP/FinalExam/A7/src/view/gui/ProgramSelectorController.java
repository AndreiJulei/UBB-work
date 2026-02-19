package view.gui;

import controller.Controller;
import exceptions.LanguageInterpreterException;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ListView;
import javafx.stage.Stage;
import model.state.*;
import model.statement.IStatement;
import model.type.IType;
import model.value.IValue;
import model.value.StringValue;
import repository.IRepository;
import repository.Repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

public class ProgramSelectorController {

    @FXML
    private ListView<IStatement> programListView;

    //private List<IStatement> programs;

    public void setPrograms(List<IStatement> programs) {
        //this.programs = programs;
        programListView.setItems(FXCollections.observableArrayList(programs));
    }

    @FXML
    public void initialize() {
        programListView.setOnMouseClicked(event -> {
            if (event.getClickCount() == 2) {
                executeSelectedProgram();
            }
        });
    }

    private void executeSelectedProgram() {
        IStatement stmt = programListView.getSelectionModel().getSelectedItem();
        if (stmt == null) return;

        try {
            stmt.typeCheck(new SymbolTable<String, IType>());

            ProgramState prg = new ProgramState(
                    new ExecutionStack<IStatement>(),
                    new SymbolTable<String, IValue>(),
                    new FileTable<StringValue, BufferedReader>(),
                    new Out<>(),
                    new Heap(),
                    stmt.deepCopy()
            );

            IRepository repo = new Repository(prg, "log.txt");
            Controller controller = new Controller(repo);

            FXMLLoader loader = new FXMLLoader(getClass().getResource("InterpreterView.fxml"));
            Parent root = loader.load();

            InterpreterController interpreterController = loader.getController();
            interpreterController.setService(new PrgStateService(controller));

            Stage stage = new Stage();
            stage.setTitle("Interpreter");
            Scene scene = new Scene(root, 800, 600);
            stage.setScene(scene);
            stage.show();

            ((Stage) programListView.getScene().getWindow()).close();

        } catch (LanguageInterpreterException e) {
            showTypeCheckError(e.getMessage());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void showTypeCheckError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Type Check Error");
        alert.setHeaderText("Program is not well-typed");
        alert.setContentText(message);
        alert.showAndWait();
    }
}
