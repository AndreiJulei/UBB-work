#pragma once
#include <QMainWindow>
#include <QTableWidget>
#include <QComboBox>
#include <QPushButton>
#include "service.h"

class MainWindow : public QMainWindow {
    Q_OBJECT
    
    private:
    Service& service;
    QTableWidget* table;
    QComboBox* speciesCombo;
    QPushButton* addButton;
    QPushButton* viewButton;

    public:
    MainWindow(Service& service, QWidget* parent = nullptr);

    private slots:
    void onSpeciesChanged();
    void onAddBacterium();
    void onViewSpecies();
};