#include "mainwindow.h"

MainWindow::MainWindow(Service &service, QWidget *parent)
    : service(service), QMainWindow(parent) {
    setWindowTitle("Meals");

    QWidget *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);
    QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
    mainLayout->setContentsMargins(10, 10, 10, 10);
    mainLayout->setSpacing(15);

    mealsTable = new QTableWidget(this);
    mealsTable->setStyleSheet("QTableWidget {"
                                "background: qlineargradient(x1:0, y1:0, x2:0, y2:1,"
                                "stop:0 #e0f7fa, stop:1rgb(0, 6, 6));"
                                "}");
    mainLayout->addWidget(mealsTable);



    addStart = new QLineEdit();
    addCalories = new QLineEdit();
    addMealType = new QLineEdit();
    
    QFormLayout *form = new QFormLayout();
    form->addRow("Add start hour:", addStart);
    form->addRow("Add Mealtype:", addMealType);
    form ->addRow("Add calories:",addCalories);
    
    mainLayout->addLayout(form);


    showMeals = new QPushButton("Show meals");
    filterCalories = new QPushButton("Filter by calories");
    filterMealType = new QPushButton("Filter by mealtype");
    exit = new QPushButton("Exit");

    QHBoxLayout *buttonLayout = new QHBoxLayout();
    buttonLayout->addWidget(showMeals);
    buttonLayout->addWidget(filterCalories);
    buttonLayout->addWidget(filterMealType);
    buttonLayout->addWidget(exit);

    mainLayout->addLayout(buttonLayout);
    populateTable();
    connectSignals();
}

void MainWindow::populateTable() {
    mealsTable->setRowCount(0);
    mealsTable->setColumnCount(5);
    mealsTable->setHorizontalHeaderLabels({"Start", "End", "Type", "Calories", "Description"});
    std::vector<Meal> meals = service.getMealsService();
    for (const auto& meal : meals) {
        int row = mealsTable->rowCount();
        mealsTable->insertRow(row);
        mealsTable->setItem(row, 0, new QTableWidgetItem(QString::number(meal.getStart())));
        mealsTable->setItem(row, 1, new QTableWidgetItem(QString::number(meal.getEnd())));
        mealsTable->setItem(row, 2, new QTableWidgetItem(QString::fromStdString(meal.getMealType())));
        mealsTable->setItem(row, 3, new QTableWidgetItem(QString::number(meal.getCalories())));
        mealsTable->setItem(row, 4, new QTableWidgetItem(QString::fromStdString(meal.getDescription())));
    }
}

void MainWindow ::connectSignals(){
    connect(showMeals, &QPushButton::clicked, this, &MainWindow::show_meals_clicked);
    connect(filterCalories, &QPushButton::clicked, this, &MainWindow::filter_by_calories_clicked);
    connect(filterMealType, &QPushButton:: clicked, this, &MainWindow::filter_by_type_clicked);
    connect(exit, &QPushButton::clicked, this, &MainWindow::close);
}



void MainWindow::show_meals_clicked() {
    QListWidget *mealsListWidget = new QListWidget();
    std::vector<Meal> meals = service.getMealsService();
    for (const auto& meal : meals) {
        QListWidgetItem *item = new QListWidgetItem(QString::fromStdString(meal.toString()));
        mealsListWidget->addItem(item);
    }
    mealsListWidget->setAttribute(Qt::WA_DeleteOnClose);
    mealsListWidget->setWindowTitle("List of meals");
    mealsListWidget->show();
}


void MainWindow::filter_by_calories_clicked(){

    int calories = addCalories->text().toInt();

    QListWidget *mealsListWidget = new QListWidget();
    std::vector<Meal> meals = service.filterListByCaloriesService(calories);
    for (const auto& meal : meals) {
        QListWidgetItem *item = new QListWidgetItem(QString::fromStdString(meal.toString()));
        mealsListWidget->addItem(item);
    }
    mealsListWidget->setAttribute(Qt::WA_DeleteOnClose);
    mealsListWidget->setWindowTitle("List of meals based on calories");
    mealsListWidget->show();
    
    addCalories->clear();
}

void MainWindow::filter_by_type_clicked(){

    std::string mtype = addMealType->text().QString::toStdString();
    int start = addStart ->text().toInt();

    QListWidget *mealsListWidget = new QListWidget();
    std::vector<Meal> meals = service.filterListService(mtype,start);
    for (const auto& meal : meals) {
        QListWidgetItem *item = new QListWidgetItem(QString::fromStdString(meal.toString()));
        mealsListWidget->addItem(item);
    }
    mealsListWidget->setAttribute(Qt::WA_DeleteOnClose);
    mealsListWidget->setWindowTitle("List of meals based on calories");
    mealsListWidget->show();
    addMealType->clear();
    addStart->clear();
}

