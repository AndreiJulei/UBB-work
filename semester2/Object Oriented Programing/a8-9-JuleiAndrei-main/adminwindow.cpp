#include "adminwindow.h"
#include "exceptions.h" // Your existing exceptions.h

AdminWindow::AdminWindow(Service& service, QWidget *parent)
    : QMainWindow(parent), m_service(service)
{
    setupUi();
    connectSignalsSlots();
    loadDogsToTable(); // Initial load of all dogs
}

AdminWindow::~AdminWindow()
{
    // No explicit deletion needed for m_dogModel if parented to QTableView
    // or if QTableView itself is parented to AdminWindow.
    // Qt's object tree handles deletion.
}

void AdminWindow::setupUi() {
    setWindowTitle("Dog Adoption - Administrator Mode");
    setMinimumSize(800, 600);

    QWidget *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);

    QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);

    // --- Dog Details Form ---
    QFormLayout *dogFormLayout = new QFormLayout();
    dogFormLayout->addRow("Breed:", breedInput = new QLineEdit());
    dogFormLayout->addRow("Name:", nameInput = new QLineEdit());
    dogFormLayout->addRow("Age:", ageInput = new QLineEdit());
    dogFormLayout->addRow("Photo URL:", photoInput = new QLineEdit());
    mainLayout->addLayout(dogFormLayout);

    // --- Action Buttons ---
    QHBoxLayout *actionButtonsLayout = new QHBoxLayout();
    QPushButton *addButton = new QPushButton("Add Dog");
    QPushButton *deleteButton = new QPushButton("Delete Dog");
    QPushButton *updateButton = new QPushButton("Update Dog");
    QPushButton *filterButton = new QPushButton("Filter Dogs");
    QPushButton *viewAllButton = new QPushButton("View All Dogs");
    actionButtonsLayout->addWidget(addButton);
    actionButtonsLayout->addWidget(deleteButton);
    actionButtonsLayout->addWidget(updateButton);
    actionButtonsLayout->addWidget(filterButton);
    actionButtonsLayout->addWidget(viewAllButton);
    mainLayout->addLayout(actionButtonsLayout);

    // --- Old Dog Details Form (for Update/Delete) ---
    QLabel* oldDogLabel = new QLabel("<b>For Update/Delete (select from table or enter manually):</b>");
    mainLayout->addWidget(oldDogLabel);

    QFormLayout *oldDogFormLayout = new QFormLayout();
    oldDogFormLayout->addRow("Old Breed:", oldBreedInput = new QLineEdit());
    oldDogFormLayout->addRow("Old Name:", oldNameInput = new QLineEdit());
    oldDogFormLayout->addRow("Old Age:", oldAgeInput = new QLineEdit());
    mainLayout->addLayout(oldDogFormLayout);

    // --- Dog Table View ---
    m_dogModel = new DogModel(m_service.get_all_dogs(), this); // Initialize with all dogs
    m_dogTableView = new QTableView();
    m_dogTableView->setModel(m_dogModel);
    m_dogTableView->setSelectionBehavior(QAbstractItemView::SelectRows); // Select entire rows
    m_dogTableView->setSelectionMode(QAbstractItemView::SingleSelection); // Only one row at a time
    m_dogTableView->horizontalHeader()->setStretchLastSection(true); // Make last column stretch
    mainLayout->addWidget(m_dogTableView);

    // Connect signals and slots
    connect(addButton, &QPushButton::clicked, this, &AdminWindow::addDog);
    connect(deleteButton, &QPushButton::clicked, this, &AdminWindow::deleteDog);
    connect(updateButton, &QPushButton::clicked, this, &AdminWindow::updateDog);
    connect(filterButton, &QPushButton::clicked, this, &AdminWindow::filterDogs);
    connect(viewAllButton, &QPushButton::clicked, this, &AdminWindow::displayAllDogs);
    connect(m_dogTableView, &QTableView::clicked, this, &AdminWindow::selectDogFromTable);
}

void AdminWindow::connectSignalsSlots() {
    // Already done in setupUi for buttons and table click
}

void AdminWindow::loadDogsToTable() {
    // This function will be called after any modification to the repository
    m_dogModel->setDogs(m_service.get_all_dogs());
}

void AdminWindow::clearInputFields() {
    breedInput->clear();
    nameInput->clear();
    ageInput->clear();
    photoInput->clear();
    oldBreedInput->clear();
    oldNameInput->clear();
    oldAgeInput->clear();
}

void AdminWindow::showErrorMessage(const std::string& message) {
    QMessageBox::critical(this, "Error", QString::fromStdString(message));
}

void AdminWindow::addDog() {
    try {
        std::string breed = breedInput->text().toStdString();
        std::string name = nameInput->text().toStdString();
        int age = ageInput->text().toInt();
        std::string photo = photoInput->text().toStdString();

        m_service.add_dog(Dog(breed, name, age, photo));
        loadDogsToTable();
        clearInputFields();
        QMessageBox::information(this, "Success", "Dog added successfully!");
    } catch (const ValidationException& e) {
        showErrorMessage(e.what());
    } catch (const RepositoryException& e) {
        showErrorMessage(e.what());
    } catch (const std::exception& e) {
        showErrorMessage(std::string("An unexpected error occurred: ") + e.what());
    }
}

void AdminWindow::deleteDog() {
    try {
        std::string breed = oldBreedInput->text().toStdString();
        std::string name = oldNameInput->text().toStdString();
        int age = oldAgeInput->text().toInt(); // Age is used for removal in your C++ code
        // Photo is not needed for removal based on your current `remove_dog` signature

        m_service.remove_dog(Dog(breed, name, age, ""));
        loadDogsToTable();
        clearInputFields();
        QMessageBox::information(this, "Success", "Dog deleted successfully!");
    } catch (const RepositoryException& e) {
        showErrorMessage(e.what());
    } catch (const std::exception& e) {
        showErrorMessage(std::string("An unexpected error occurred: ") + e.what());
    }
}

void AdminWindow::updateDog() {
    try {
        std::string oldBreed = oldBreedInput->text().toStdString();
        std::string oldName = oldNameInput->text().toStdString();
        int oldAge = oldAgeInput->text().toInt();
        // Old photo is not used in your update_dog signature for finding the dog
        std::string oldPhoto = ""; // Placeholder

        std::string newBreed = breedInput->text().toStdString();
        std::string newName = nameInput->text().toStdString();
        int newAge = ageInput->text().toInt();
        std::string newPhoto = photoInput->text().toStdString();

        Dog oldDog(oldBreed, oldName, oldAge, oldPhoto);
        Dog newDog(newBreed, newName, newAge, newPhoto);

        m_service.update_dog(oldDog, newDog);
        loadDogsToTable();
        clearInputFields();
        QMessageBox::information(this, "Success", "Dog updated successfully!");
    } catch (const ValidationException& e) {
        showErrorMessage(e.what());
    } catch (const RepositoryException& e) {
        showErrorMessage(e.what());
    } catch (const std::exception& e) {
        showErrorMessage(std::string("An unexpected error occurred: ") + e.what());
    }
}

void AdminWindow::filterDogs() {
    try {
        std::string breed = breedInput->text().toStdString();
        int age = ageInput->text().toInt();

        // If age input is empty or invalid, treat as "no max age"
        if (ageInput->text().isEmpty() || age == 0) { // Assuming 0 is not a valid age for filtering "all"
            age = std::numeric_limits<int>::max();
        }

        std::vector<Dog> filteredDogs = m_service.filter_dogs(breed, age);
        m_dogModel->setDogs(filteredDogs); // Update the table with filtered results
        QMessageBox::information(this, "Filter Results",
                                 QString("Displayed %1 dogs matching criteria.").arg(filteredDogs.size()));
    } catch (const std::exception& e) {
        showErrorMessage(std::string("An unexpected error occurred during filter: ") + e.what());
    }
}

void AdminWindow::displayAllDogs() {
    loadDogsToTable(); // Reload all dogs from the service
    clearInputFields(); // Clear any filter criteria
    QMessageBox::information(this, "View All", "Displaying all dogs in the repository.");
}

void AdminWindow::selectDogFromTable(const QModelIndex &index) {
    if (!index.isValid())
        return;

    // Get the selected row's data
    int row = index.row();
    std::string breed = m_dogModel->data(m_dogModel->index(row, 0)).toString().toStdString();
    std::string name = m_dogModel->data(m_dogModel->index(row, 1)).toString().toStdString();
    int age = m_dogModel->data(m_dogModel->index(row, 2)).toInt();
    std::string photo = m_dogModel->data(m_dogModel->index(row, 3)).toString().toStdString();

    // Populate the "old dog" fields for update/delete
    oldBreedInput->setText(QString::fromStdString(breed));
    oldNameInput->setText(QString::fromStdString(name));
    oldAgeInput->setText(QString::number(age));

    // Populate the "new dog" fields for convenience (user can edit these)
    breedInput->setText(QString::fromStdString(breed));
    nameInput->setText(QString::fromStdString(name));
    ageInput->setText(QString::number(age));
    photoInput->setText(QString::fromStdString(photo));
}
