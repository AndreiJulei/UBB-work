#pragma once
#include <QMainWindow>
#include "ui_MainWindow.h"
#include "service.h"

class MainWindow : public QMainWindow {
Q_OBJECT

public:
    MainWindow(Service& service,QWidget *parent = nullptr);
    ~MainWindow() override;
private:
    Ui::MainWindow *ui;
    Service& service;
private slots:
    void on_add_equation_clicked();
    void show_solutions();
};

