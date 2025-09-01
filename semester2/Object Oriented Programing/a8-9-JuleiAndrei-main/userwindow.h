#ifndef USERWINDOW_H
#define USERWINDOW_H

#include <QMainWindow>
#include <QPushButton>
#include <QLineEdit>
#include <QLabel>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QMessageBox>
#include <QDesktopServices> // For opening files/URLs

#include "service.h" // Your existing service.h

class UserWindow : public QMainWindow {
    Q_OBJECT

public:
    explicit UserWindow(Service& service, QWidget *parent = nullptr);
    ~UserWindow();

private slots:
    void displayNextDog();
    void adoptCurrentDog();
    void filterDogsForAdoption();
    void viewAdoptionList();

private:
    Service& m_service;
    std::vector<Dog> m_availableDogs; // Dogs currently being browsed by the user
    int m_currentDogIndex;

    // UI elements
    QLabel* currentDogDisplay;
    QLineEdit* filterBreedInput;
    QLineEdit* filterAgeInput;

    void setupUi();
    void connectSignalsSlots();
    void updateCurrentDogDisplay();
    void showErrorMessage(const std::string& message);
};

#endif // USERWINDOW_H
