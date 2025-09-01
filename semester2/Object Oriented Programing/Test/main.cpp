#include <QApplication>
#include "repo.h"
#include "service.h"
#include "mainwindow.h"

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);
    Repository repo;
    Service service(repo);
    MainWindow w(service);
    w.show();
    return QApplication::exec();
}