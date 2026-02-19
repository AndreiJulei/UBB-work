package view.gui;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import model.state.ProgramState;
import model.value.IValue;
import model.value.StringValue;

import java.util.List;
import java.util.Map;

public class InterpreterController {

    @FXML
    private ListView<ProgramState> prgStateListView;
    @FXML
    private TextField prgStateCountField;

    @FXML
    private TableView<Map.Entry<Integer, IValue>> heapTable;
    @FXML
    private TableColumn<Map.Entry<Integer, IValue>, String> heapAddressColumn;
    @FXML
    private TableColumn<Map.Entry<Integer, IValue>, String> heapValueColumn;

    @FXML
    private TableView<Map.Entry<String, IValue>> symTable;
    @FXML
    private TableColumn<Map.Entry<String, IValue>, String> symVarColumn;
    @FXML
    private TableColumn<Map.Entry<String, IValue>, String> symValueColumn;

    @FXML
    private ListView<IValue> outListView;
    @FXML
    private ListView<String> exeStackView;
    @FXML
    private ListView<String> fileTableView;


    private PrgStateService service;

    private boolean isRefreshing = false;

    public void setService(PrgStateService service) {
        this.service = service;
        init();
    }

    private void init() {
        // Listener for program state selection
        prgStateListView.getSelectionModel()
                .selectedItemProperty()
                .addListener((obs, oldVal, newVal) -> {
                    if (newVal != null) updateDetails(newVal);
                });

        symVarColumn.setCellValueFactory(
                cell -> new javafx.beans.property.SimpleStringProperty(cell.getValue().getKey())
        );
        symValueColumn.setCellValueFactory(
                cell -> new javafx.beans.property.SimpleStringProperty(cell.getValue().getValue().toString())
        );

        heapAddressColumn.setCellValueFactory(
                cell -> new javafx.beans.property.SimpleStringProperty(cell.getValue().getKey().toString())
        );
        heapValueColumn.setCellValueFactory(
                cell -> new javafx.beans.property.SimpleStringProperty(cell.getValue().getValue().toString())
        );

        refresh();
    }

    @FXML
    public void runOneStep() {
        service.oneStep();
        refresh();
    }

    private void refresh() {
        if (isRefreshing) return;
        isRefreshing = true;

        List<ProgramState> programs = service.getPrograms();
        prgStateCountField.setText(String.valueOf(programs.size()));

        if (programs.isEmpty()) {
            prgStateListView.setItems(FXCollections.observableArrayList());
            heapTable.setItems(FXCollections.observableArrayList());
            symTable.setItems(FXCollections.observableArrayList());
            outListView.setItems(FXCollections.observableArrayList());
            exeStackView.setItems(FXCollections.observableArrayList());
            isRefreshing = false;
            return;
        }

        prgStateListView.setItems(FXCollections.observableArrayList(programs));
        prgStateListView.setCellFactory(lv -> new ListCell<>() {
            @Override
            protected void updateItem(ProgramState item, boolean empty) {
                super.updateItem(item, empty);
                if (empty || item == null) setText(null);
                else setText("Program State " + (getIndex() + 1));
            }
        });

        if (prgStateListView.getSelectionModel().getSelectedItem() == null) {
            prgStateListView.getSelectionModel().selectFirst();
        }

        ProgramState selected = prgStateListView.getSelectionModel().getSelectedItem();
        if (selected != null) updateDetails(selected);

        isRefreshing = false;
    }

    private void updateDetails(ProgramState prg) {
        // Heap table
        heapTable.setItems(FXCollections.observableArrayList(
                prg.heap().getAll().entrySet()
        ));
        heapTable.refresh();

        // Symbol table
        symTable.setItems(FXCollections.observableArrayList(
                prg.symbolTable().getAll().entrySet()
        ));
        symTable.refresh();

        // Output
        outListView.setItems(FXCollections.observableArrayList(
                prg.out().getAll()
        ));

        // Execution stack
        exeStackView.setItems(FXCollections.observableArrayList(
                prg.executionStack().getAll().stream()
                        .map(Object::toString)
                        .toList()
        ));

        // File Table
        fileTableView.setItems(FXCollections.observableArrayList(
                prg.fileTable().getAll().keySet().stream()
                        .map(StringValue::value)
                        .toList()
        ));
    }
}
