main.cpp
#include <QApplication>
#include <QMessageBox>
#include <QInputDialog>
#include <cstdio> // For std::remove
#include <iostream> // For console input (initial file type and mode selection)

#include "adminwindow.h"
#include "userwindow.h"
#include "service.h" // Your existing service.h

// Forward declarations for your existing classes (if not in headers)
// #include "domain.h"
// #include "dynamicvector.h"
// #include "validators.h"
// #include "exceptions.h"

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);

    // --- Initial console-based setup (as per your original main.cpp) ---
    std::remove("adopted.csv");
    std::remove("adopted.html");
    std::remove("dogs.txt"); // Ensure dogs.txt is cleared or initialized

    std::string fileType;
    bool fileTypeChosen = false;
    while (!fileTypeChosen) {
        QString input = QInputDialog::getText(nullptr, "File Type Selection",
                                              "Choose file type for shopping basket (csv/html) or '0' to exit:",
                                              QLineEdit::Normal, "csv");
        if (input == "0") {
            return 0; // Exit application
        } else if (input == "html" || input == "csv") {
            fileType = input.toStdString();
            fileTypeChosen = true;
        } else {
            QMessageBox::warning(nullptr, "Invalid Input", "Wrong file type! Please enter 'csv' or 'html'.");
        }
    }

    Service service(fileType);

    // Add initial dogs (as per your original main.cpp)
    service.add_dog(Dog("Golden Retriever", "Buddy", 7, "http://photo.com/goldenretriever.jpg"));
    service.add_dog(Dog("Labrador Retriever", "Bella", 5, "http://photo.com/labrador.jpg"));
    service.add_dog(Dog("German Shepherd", "Max", 9, "http://photo.com/germanshepherd.jpg"));
    service.add_dog(Dog("Poodle", "Coco", 3, "http://photo.com/poodle.jpg"));
    service.add_dog(Dog("Bulldog", "Winston", 6, "http://photo.com/bulldog.jpg"));
    service.add_dog(Dog("Beagle", "Daisy", 4, "http://photo.com/beagle.jpg"));
    service.add_dog(Dog("Rottweiler", "Rocky", 8, "http://photo.com/rottweiler.jpg"));
    service.add_dog(Dog("Yorkshire Terrier", "Lucy", 10, "http://photo.com/yorkie.jpg"));
    service.add_dog(Dog("Boxer", "Gus", 2, "http://photo.com/boxer.jpg"));

    // --- GUI Mode Selection ---
    QMessageBox modeSelectionBox;
    modeSelectionBox.setWindowTitle("Mode Selection");
    modeSelectionBox.setText("Choose application mode:");
    QPushButton *adminButton = modeSelectionBox.addButton("Admin Mode", QMessageBox::ActionRole);
    QPushButton *userButton = modeSelectionBox.addButton("User Mode", QMessageBox::ActionRole);
    modeSelectionBox.setDefaultButton(adminButton);
    modeSelectionBox.exec();

    if (modeSelectionBox.clickedButton() == adminButton) {
        AdminWindow adminWindow(service);
        adminWindow.show();
        return a.exec();
    } else if (modeSelectionBox.clickedButton() == userButton) {
        UserWindow userWindow(service);
        userWindow.show();
        return a.exec();
    }

    return 0; // Should not be reached
}
