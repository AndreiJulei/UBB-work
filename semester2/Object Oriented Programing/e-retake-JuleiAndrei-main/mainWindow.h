#pragma once
#include "service.h"
#include "observer.h"
#include <QWidget>
#include <QString>
#include <QMainWindow>
#include <QListWidget>
#include <QPushButton>
#include <QTableWidget>
#include <QLabel>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLineEdit>
#include <QCheckBox>

class ChefWindow : public QMainWindow,public Observer {
    Q_OBJECT

    private:
    Service &service;
    Chef chef;

    //filter by cuisine:
    QCheckBox *filterCheckBox;
    QListWidget *recipeList;

    //add:
    QPushButton *addButton;
    QLineEdit *nameLine;
    QLineEdit *timeLine;
    QLineEdit *ingredientsLine;

    //search by ingredients:
    QPushButton *searchByIngredientsButton;

    void populateList(bool checked = false);

    public:
    ChefWindow(Service &service, Chef chef,QWidget* parent = nullptr);

    void update() override;

    private slots:
    void onAddClicked();
    void onSearchClicked();
    void onFilterToggle(bool checked);
};