#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "service.h"
#include <QList>
#include <QMainWindow>
#include <QLabel>
#include <QPushButton>
#include <QLineEdit>
#include <QTableWidget>
#include <QDoubleValidator>
#include <QFormLayout>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QListWidget>
#include <QMessageBox>

class MainWindow : public QMainWindow {
    Q_OBJECT
public:
    MainWindow(Service &service, QWidget *parent = nullptr);

private:
    Service &service;

    QTableWidget *mealsTable;
    QTableWidget *calorieTable;
    QTableWidget *mealTypeTable;

    QLineEdit *addStart;
    QLineEdit *addCalories;
    QLineEdit *addMealType;

    QPushButton *showMeals;
    QPushButton *filterCalories;
    QPushButton *filterMealType;
    QPushButton *exit;

private slots:
    void show_meals_clicked();
    void filter_by_calories_clicked();
    void filter_by_type_clicked();

private:
    void populateTable();
    void connectSignals();


};


#endif