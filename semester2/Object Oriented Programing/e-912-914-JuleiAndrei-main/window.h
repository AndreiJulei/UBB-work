#pragma once

#include <QMainWindow>
#include <QPushButton>
#include <QTableWidget>
#include <QLineEdit>
#include "mainWindow.h"
#include "service.h"

class Window : public QMainWindow {
    Q_OBJECT

private:
    MainWindow& mw;
    Service& service;
    QPushButton* selectBiologistButton;
    QPushButton* exitButton;
    QTableWidget* itemsTable;
    QLineEdit* biologistNameLine;

    void populateTable();

private slots:
    void selectBiologistClicked();

public:
    Window(MainWindow& mw, Service& service, QWidget* parent = nullptr);
};