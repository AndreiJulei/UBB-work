#include "mainWindow.h"
#include <QVBoxLayout>
#include <QInputDialog>
#include <QPainter>
#include <QMessageBox>
#include <QWidget>

MainWindow::MainWindow(Service& service, QWidget* parent)
    : QMainWindow(parent), service(service) {
    QWidget* central = new QWidget;
    QVBoxLayout* layout = new QVBoxLayout;

    speciesCombo = new QComboBox;
    for (const auto& s : service.getSpecies()) speciesCombo->addItem(QString::fromStdString(s));
    connect(speciesCombo, &QComboBox::currentTextChanged, this, &MainWindow::onSpeciesChanged);

    table = new QTableWidget;
    addButton = new QPushButton("Add Bacterium");
    viewButton = new QPushButton("View Species");

    connect(addButton, &QPushButton::clicked, this, &MainWindow::onAddBacterium);
    connect(viewButton, &QPushButton::clicked, this, &MainWindow::onViewSpecies);

    layout->addWidget(speciesCombo);
    layout->addWidget(table);
    layout->addWidget(addButton);
    layout->addWidget(viewButton);
    central->setLayout(layout);
    setCentralWidget(central);

    onSpeciesChanged();
}

void MainWindow::onSpeciesChanged() {
    std::string species = speciesCombo->currentText().toStdString();
    auto bacteria = service.getBacteriaBySpecies(species);
    table->setRowCount(bacteria.size());
    table->setColumnCount(3);
    table->setHorizontalHeaderLabels({"Name", "Size", "Diseases"});
    for (int i = 0; i < bacteria.size(); ++i) {
        table->setItem(i, 0, new QTableWidgetItem(QString::fromStdString(bacteria[i].getName())));
        table->setItem(i, 1, new QTableWidgetItem(QString::number(bacteria[i].getSize())));
        QString diseases = QString::fromStdString(
            std::accumulate(bacteria[i].getDiseases().begin(), bacteria[i].getDiseases().end(), std::string(),
            [](const std::string& a, const std::string& b) { return a.empty() ? b : a + ", " + b; }));
        table->setItem(i, 2, new QTableWidgetItem(diseases));
    }
}

void MainWindow::onAddBacterium() {
    bool ok;
    QString name = QInputDialog::getText(this, "Add Bacterium", "Bacterium name:", QLineEdit::Normal, "", &ok);
    if (!ok || name.isEmpty()) return;

    QString species = QInputDialog::getText(this, "Add Bacterium", "Species:", QLineEdit::Normal, speciesCombo->currentText(), &ok);
    if (!ok || species.isEmpty()) return;

    // Check for duplicate bacterium (same name and species)
    std::vector<Bacterium> existingBacteria = service.getBacteriaBySpecies(species.toStdString());
    for (const auto& b : existingBacteria) {
        if (QString::fromStdString(b.getName()).compare(name, Qt::CaseInsensitive) == 0) {
            QMessageBox::warning(this, "Duplicate Bacterium",
                                 "A bacterium with the name '" + name + "' already exists in the species '" + species + "'.");
            return; // Stop the function if a duplicate is found
        }
    }

    int size = QInputDialog::getInt(this, "Add Bacterium", "Size:", 1, 1, 10000, 1, &ok);
    if (!ok) return;

    QString diseasesStr = QInputDialog::getText(this, "Add Bacterium", "Diseases (comma separated):", QLineEdit::Normal, "", &ok);
    if (!ok) return;

    std::vector<std::string> diseaseList;
    for (const auto& d : diseasesStr.split(',', Qt::SkipEmptyParts)) {
        diseaseList.push_back(d.trimmed().toStdString());
    }

    service.addBacterium(Bacterium(name.toStdString(), species.toStdString(), size, diseaseList));
    
    if (speciesCombo->findText(species) == -1) {
        speciesCombo->addItem(species);
    }
    speciesCombo->setCurrentText(species);
    
    onSpeciesChanged();
}
void MainWindow::onViewSpecies() {
    QWidget* viewWin = new QWidget;
    viewWin->setWindowTitle("Species View");
    viewWin->resize(400, 400);
    viewWin->show();
}