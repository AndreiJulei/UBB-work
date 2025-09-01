#include "window.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QInputDialog>
#include <QApplication>
#include <QHeaderView>
#include <QPainter>
#include <QWidget>
#include <QMessageBox>

Window::Window(MainWindow& mw, Service& service, QWidget* parent)
    : QMainWindow(parent), mw(mw), service(service) {
    QWidget* centralWidget = new QWidget(this);
    QVBoxLayout* mainLayout = new QVBoxLayout(centralWidget);

    itemsTable = new QTableWidget(this);
    itemsTable->setColumnCount(1);
    QStringList headers;
    headers << "Name";
    itemsTable->setHorizontalHeaderLabels(headers);
    itemsTable->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    mainLayout->addWidget(itemsTable);

    QHBoxLayout* inputLayout = new QHBoxLayout();

    biologistNameLine = new QLineEdit(this);
    biologistNameLine->setPlaceholderText("Enter biologist name");

    selectBiologistButton = new QPushButton("Select Biologist");
    exitButton = new QPushButton("Exit");

    inputLayout->addWidget(biologistNameLine);
    inputLayout->addWidget(selectBiologistButton);
    inputLayout->addWidget(exitButton);
    mainLayout->addLayout(inputLayout);

    setCentralWidget(centralWidget);

    connect(selectBiologistButton, &QPushButton::clicked, this, &Window::selectBiologistClicked);
    connect(exitButton, &QPushButton::clicked, qApp, &QApplication::quit);

    resize(800, 600);
    populateTable();
}

void Window::selectBiologistClicked() {
    QString biologistName = biologistNameLine->text().trimmed();
    if (biologistName.isEmpty()) {
        QMessageBox::warning(this, "Input Error", "Please enter a biologist name.");
        return;
    }

    bool found = false;
    for (const auto& b : service.getBiologists()) {
        if (QString::fromStdString(b.getName()).compare(biologistName, Qt::CaseInsensitive) == 0) {
            found = true;
            break;
        }
    }

    if (found) {
        mw.setWindowTitle(QString("Biologist Dashboard - %1").arg(biologistName));
        mw.show();
        this->hide();
    } else {
        QMessageBox::critical(this, "Biologist Not Found", "The entered biologist name does not exist. Please try again.");
    }
}


void Window::populateTable() {
    std::vector<Biologist> biologists = service.getBiologists();
    itemsTable->setRowCount(biologists.size());
    int row = 0;
    for (const auto& b : biologists) {
        QTableWidgetItem* name = new QTableWidgetItem(QString::fromStdString(b.getName()));
        itemsTable->setItem(row, 0, name);
        row++;
    }
}