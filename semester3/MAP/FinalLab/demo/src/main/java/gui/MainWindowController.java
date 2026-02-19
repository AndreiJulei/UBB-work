package gui;

import controller.Controller;
import exceptions.MyException;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import model.PrgState;
import model.statements.IStmt;
import model.values.Value;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class MainWindowController {
    private Controller controller;
    
    @FXML private TextField nrPrgStatesField;
    @FXML private TableView<Map.Entry<Integer, Value>> heapTable; 
    @FXML private TableColumn<Map.Entry<Integer, Value>, Integer> heapAddrColumn;
    @FXML private TableColumn<Map.Entry<Integer, Value>, Value> heapValueColumn;
    @FXML private ListView<Value> outList;
    @FXML private ListView<String> fileList;
    @FXML private ListView<Integer> prgStateIdList;
    @FXML private TableView<Map.Entry<String, Value>> symTable;
    @FXML private TableColumn <Map.Entry<String, Value>, String> symVarColumn;
    @FXML private TableColumn<Map.Entry<String, Value>, Value> symValueColumn;
    @FXML private ListView<String> exeStackList;
    @FXML private Button runOneStepButton;

    public void setController(Controller ctrl){
        this.controller=ctrl;
        populate();
    }

    @FXML
    public void initialize(){
        // Setup columns
        heapAddrColumn.setCellValueFactory(p -> new javafx.beans.property.SimpleObjectProperty<>(p.getValue().getKey()));
        heapValueColumn.setCellValueFactory(p -> new javafx.beans.property.SimpleObjectProperty<>(p.getValue().getValue()));
        symVarColumn.setCellValueFactory(p -> new javafx.beans.property.SimpleObjectProperty(p.getValue().getKey()));
        symValueColumn.setCellValueFactory(p -> new javafx.beans.property.SimpleObjectProperty<>(p.getValue().getValue()));

        // Listener: when a new id is clicked update execution stack and symbol table
        prgStateIdList.getSelectionModel().selectedItemProperty().addListener((observable, oldValue, newValue) -> populateSelectedPrgState());
    }

    public void populate(){
        List<PrgState> prgStates = controller.getRepo().getPrgList();

        nrPrgStatesField.setText(String.valueOf(prgStates.size()));

        // update global shared structures(heap, out, fileTable)
        if(!prgStates.isEmpty()){
            PrgState anyState = prgStates.get(0);
            heapTable.setItems(FXCollections.observableArrayList(anyState.getHeap().getContent().entrySet()));
            outList.setItems(FXCollections.observableArrayList(anyState.getOut().getList()));
            fileList.setItems(FXCollections.observableArrayList(
                anyState.getFileTable().getContent().keySet().stream().map(v -> v.getVal()).collect(Collectors.toList())
            ));
        }

        prgStateIdList.setItems(FXCollections.observableArrayList(
            prgStates.stream().map(PrgState::getId).collect(Collectors.toList())
        ));
        
        populateSelectedPrgState();
    }

    private void populateSelectedPrgState(){
        // select the State corresponding to the selected id in the listView 
        Integer selectedId = prgStateIdList.getSelectionModel().getSelectedItem();
        PrgState selectedState = controller.getRepo().getPrgList().stream()
                .filter(p -> p.getId() == (selectedId == null ? -1 : selectedId))
                .findFirst().orElse(null);
        
        if (selectedState != null) {
            symTable.setItems(FXCollections.observableArrayList(selectedState.getSymTable().getContent().entrySet()));
            exeStackList.setItems(FXCollections.observableArrayList(
                selectedState.getStk().getReversed().stream().map(Object::toString).collect(Collectors.toList())
            ));
        } else {
            symTable.getItems().clear();
            exeStackList.getItems().clear();
        }       
    }

    @FXML
    public void handleRunOneStep(){
        if (controller == null) return;
        try{
            List<PrgState> prgList = controller.removeCompletedPrg(controller.getRepo().getPrgList());
            if (prgList.isEmpty()){
                showError("Program has finished execution!");
            }
            controller.oneStepForAllPrg(prgList);
            populate();
        } catch(Exception e){
            showError(e.getMessage());
        }
    }

    public boolean hasController() {
        return controller != null;
    }

    private void showError(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setContentText(message);
        alert.showAndWait(); // [cite: 328]
    }
}   