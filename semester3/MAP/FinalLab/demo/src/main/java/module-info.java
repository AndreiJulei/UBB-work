module com.example {
    requires javafx.controls;
    requires javafx.fxml;

    opens com.example to javafx.fxml;
    opens gui to javafx.fxml, javafx.graphics;
    exports com.example;
}