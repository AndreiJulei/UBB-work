#include <QApplication>
#include <QList>
#include "repository.h"
#include "service.h"
#include "mainWindow.h"

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    
    Repo repo;
    Service service(repo);
    
    vector <Chef> chefs = repo.getChefs();
    vector <ChefWindow*> views;
    
    for (const Chef & chef : chefs) {
        ChefWindow* view = new ChefWindow(service, chef);
        view->show();
        views.push_back(view);
    }
    
    int result = app.exec();
    
    for (ChefWindow* view : views) {
        delete view;
    }
    
    return result;
}