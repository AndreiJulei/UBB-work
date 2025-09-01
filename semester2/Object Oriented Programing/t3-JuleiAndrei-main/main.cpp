#include <QApplication>
#include "mainwindow.h"
#include "service.h"
#include "repository.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    std :: vector <Meal> initialMeals;
    Repo repo(initialMeals);
    repo.addMeal(Meal(7,3,"brekfast",300,"oatmeal"));
    repo.addMeal(Meal(8,2,"snack",200,"candy bar"));
    repo.addMeal(Meal(10,11,"snack",500,"chocolate"));


    Service service(repo);

    MainWindow mainWindow(service);

    mainWindow.show();  
    return app.exec();
}
