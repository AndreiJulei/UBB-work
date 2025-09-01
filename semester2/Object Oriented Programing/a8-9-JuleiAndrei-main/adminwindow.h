#ifndef ADMINWINDOW_H
#define ADMINWINDOW_H

#include <QMainWindow>
#include <QTableView>
#include <QPushButton>
#include <QLineEdit>
#include <QLabel>
#include <QFormLayout>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QMessageBox>

#include "service.h" // Your existing service.h
#include "dogmodel.h" // The custom model we just defined

class AdminWindow : public QMainWindow {
    Q_OBJECT

public:
    explicit AdminWindow(Service& service, QWidget *parent = nullptr);
    ~AdminWindow();

private slots:
    void addDog();
    void deleteDog();
    void updateDog();
    void filterDogs();
    void displayAllDogs();
    void selectDogFromTable(const QModelIndex &index);

private:
    Service& m_service;
    DogModel* m_dogModel;
    QTableView* m_dogTableView;

    // Input fields for dog details
    QLineEdit* breedInput;
    QLineEdit* nameInput;
    QLineEdit* ageInput;
    QLineEdit* photoInput;

    // Input fields for old dog details (for update/delete)
    QLineEdit* oldBreedInput;
    QLineEdit* oldNameInput;
    QLineEdit* oldAgeInput;

    void setupUi();
    void connectSignalsSlots();
    void loadDogsToTable();
    void clearInputFields();
    void showErrorMessage(const std::string& message);
};

#endif // ADMINWINDOW_H

