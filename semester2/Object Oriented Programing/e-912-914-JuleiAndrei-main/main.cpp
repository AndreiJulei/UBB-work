#include <QApplication>
#include "repository.h"
#include "service.h"
#include "mainWindow.h"
#include "window.h"

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);

    Repository repo;
    repo.loadBiologists("biologists.txt");
    repo.loadBacteria("bacteria.txt");

    Service service(repo);

    MainWindow w(service);

    Window ww(w, service);
    ww.show();

    int ret = a.exec();

    service.saveAll("bacteria.txt");

    return ret;
}