#include "mainWindow.h"
#include <QMessageBox>

ChefWindow::ChefWindow(Service &service, Chef chef, QWidget* parent)
    : QMainWindow(parent), service(service), chef(chef){
    
    service.getRepo().addObserver(this);
    QWidget* centralWidget = new QWidget();
    QVBoxLayout* mainLayout = new QVBoxLayout(centralWidget);
    setWindowTitle(QString::fromStdString(chef.getName()));

    // Layout for adding and searching 
    QHBoxLayout* addLayout = new QHBoxLayout();
    nameLine = new QLineEdit();
    addLayout->addWidget(nameLine);
    timeLine = new QLineEdit();
    addLayout->addWidget(timeLine);
    ingredientsLine = new QLineEdit();
    addLayout->addWidget(ingredientsLine);
    addButton = new QPushButton("Add");
    addLayout->addWidget(addButton);
    searchByIngredientsButton = new QPushButton("Search");
    addLayout->addWidget(searchByIngredientsButton);
    mainLayout->addLayout(addLayout);

    // Layout for list of recipes
    recipeList = new QListWidget();
    mainLayout->addWidget(recipeList);

    // Layout for CheckBox
    filterCheckBox = new QCheckBox("Show only Speciality cuisines", this);
    mainLayout->addWidget(filterCheckBox);

    setCentralWidget(centralWidget);

    connect(filterCheckBox, &QCheckBox::toggled, this, &ChefWindow::onFilterToggle);
    connect(addButton,&QPushButton::clicked, this,&ChefWindow :: onAddClicked);
    connect(searchByIngredientsButton,&QPushButton::clicked, this,&ChefWindow :: onSearchClicked);

    populateList();
}
void ChefWindow::populateList(bool checked) {
    recipeList->clear();
    vector<Recipe> recipes;
    if (checked) {
        recipes = service.getRecipesByCuisine(chef.getCuisineSpeciality());
    } else {
        recipes = service.getRecipes();
    }
    for (auto& r : recipes) {
        QString itemText = QString::fromStdString(r.getName()) + " | ";
        itemText += QString::fromStdString(r.getCuisine()) + " | ";
        itemText += QString::number(r.getPreparationTime()) + " | ";
        vector<string> ingredients = r.getListOfIngredients();
        for (size_t i = 0; i < ingredients.size(); ++i) {
            itemText += QString::fromStdString(ingredients[i]);
            if (i != ingredients.size() - 1) {
                itemText += ",";
            }
        }
        QListWidgetItem* item = new QListWidgetItem(itemText);
        recipeList->addItem(item);
    }
}

void ChefWindow::onAddClicked(){
    QString name = nameLine->text().trimmed();
    QString prepTime = timeLine->text().trimmed();
    QString listOfIngredients = ingredientsLine->text().trimmed();

    if(name.isEmpty() || prepTime.isEmpty() || listOfIngredients.isEmpty()){
        QMessageBox::warning(this, "Error", "Please fill all fields");
    } else {
        vector <string> stringIngredients;
        QStringList ingredientList = listOfIngredients.split(",");
        for (const QString& ing : ingredientList) {
            stringIngredients.push_back(ing.trimmed().toStdString());
        }
        if (service.addRecipeService(name.toStdString(), prepTime.toInt(), stringIngredients, chef) == false){
            QMessageBox :: warning(this, "Error", "Dish with the same name exists");
        }else{
            update();
            nameLine->clear();
            timeLine->clear();
            ingredientsLine->clear();
        }
    }
}

void ChefWindow::onSearchClicked(){
    QString listOfIngredients = ingredientsLine->text().trimmed();

    if(listOfIngredients.isEmpty()){
        QMessageBox::warning(this, "Error", "Please enter ingredients");
    } else {
        vector<string> stringIngredients;
        QStringList ingredientList = listOfIngredients.split(",");
        for (const QString& ing : ingredientList) {
            stringIngredients.push_back(ing.trimmed().toStdString());
        }
        vector<Recipe> foundRecipes = service.getRecipesByIngredients(stringIngredients);
        recipeList->clear();
        for (auto& r : foundRecipes) {
            QString itemText = QString::fromStdString(r.getName()) + " | ";
            itemText += QString::fromStdString(r.getCuisine()) + " | ";
            itemText += QString::number(r.getPreparationTime()) + " | ";
            vector<string> ingredients = r.getListOfIngredients();
            for (size_t i = 0; i < ingredients.size(); ++i) {
                itemText += QString::fromStdString(ingredients[i]);
                if (i != ingredients.size() - 1) {
                    itemText += ",";
                }
            }
            QListWidgetItem* item = new QListWidgetItem(itemText);
            recipeList->addItem(item);
        }
        ingredientsLine->clear();
    }
}

void ChefWindow::onFilterToggle(bool checked) {
    populateList(checked);
}

void ChefWindow::update() {
    populateList(filterCheckBox->isChecked());
}
