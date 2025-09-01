// userwindow.cpp
#include "userwindow.h"
#include <limits> // For std::numeric_limits

UserWindow::UserWindow(Service& service, QWidget *parent)
    : QMainWindow(parent), m_service(service), m_currentDogIndex(0)
{
    // Initialize available dogs with all dogs from service
    m_availableDogs = m_service.get_all_dogs();
    setupUi();
    connectSignalsSlots();
    updateCurrentDogDisplay(); // Display the first dog
}

UserWindow::~UserWindow()
{
    // Destructor
}

void UserWindow::setupUi() {
    setWindowTitle("Dog Adoption - User Mode");
    setMinimumSize(600, 400);

    QWidget *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);

    QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);

    // --- Current Dog Display ---
    currentDogDisplay = new QLabel("No dogs available.");
    currentDogDisplay->setWordWrap(true);
    currentDogDisplay->setAlignment(Qt::AlignCenter);
    currentDogDisplay->setStyleSheet("font-size: 18px; padding: 10px; border: 1px solid gray; border-radius: 5px;");
    mainLayout->addWidget(currentDogDisplay);

    // --- Navigation/Action Buttons ---
    QHBoxLayout *dogNavButtonsLayout = new QHBoxLayout();
    QPushButton *adoptButton = new QPushButton("Adopt Current Dog");
    QPushButton *nextButton = new QPushButton("Next Dog");
    dogNavButtonsLayout->addWidget(adoptButton);
    dogNavButtonsLayout->addWidget(nextButton);
    mainLayout->addLayout(dogNavButtonsLayout);

    // --- Filter Section ---
    QLabel* filterLabel = new QLabel("<b>Filter Dogs:</b>");
    mainLayout->addWidget(filterLabel);

    QHBoxLayout *filterInputsLayout = new QHBoxLayout();
    filterBreedInput = new QLineEdit();
    filterBreedInput->setPlaceholderText("Breed (leave empty for all)");
    filterAgeInput = new QLineEdit();
    filterAgeInput->setPlaceholderText("Max Age (leave empty for all)");
    filterInputsLayout->addWidget(filterBreedInput);
    filterInputsLayout->addWidget(filterAgeInput);
    mainLayout->addLayout(filterInputsLayout);

    QPushButton *filterButton = new QPushButton("Apply Filter");
    mainLayout->addWidget(filterButton);

    // --- Adoption List Button ---
    QPushButton *viewAdoptionListButton = new QPushButton("View Adoption List");
    mainLayout->addWidget(viewAdoptionListButton);

    // Connect signals and slots
    connect(nextButton, &QPushButton::clicked, this, &UserWindow::displayNextDog);
    connect(adoptButton, &QPushButton::clicked, this, &UserWindow::adoptCurrentDog);
    connect(filterButton, &QPushButton::clicked, this, &UserWindow::filterDogsForAdoption);
    connect(viewAdoptionListButton, &QPushButton::clicked, this, &UserWindow::viewAdoptionList);
}

void UserWindow::connectSignalsSlots() {
    // Already done in setupUi
}

void UserWindow::updateCurrentDogDisplay() {
    if (m_availableDogs.empty()) {
        currentDogDisplay->setText("No dogs currently available for adoption.");
        return;
    }

    // Ensure index wraps around
    m_currentDogIndex %= m_availableDogs.size();
    const Dog& d = m_availableDogs[m_currentDogIndex];
    QString displayHtml = QString(
        "<b>Breed:</b> %1<br>"
        "<b>Name:</b> %2<br>"
        "<b>Age:</b> %3<br>"
        "<b>Photo:</b> <a href=\"%4\">View Photo</a>"
    ).arg(QString::fromStdString(d.get_breed()))
     .arg(QString::fromStdString(d.get_name()))
     .arg(d.get_age())
     .arg(QString::fromStdString(d.get_photo()));

    currentDogDisplay->setText(displayHtml);
    currentDogDisplay->setTextFormat(Qt::RichText); // Enable HTML rendering
    currentDogDisplay->setOpenExternalLinks(true); // Allow clicking photo link
}

void UserWindow::showErrorMessage(const std::string& message) {
    QMessageBox::critical(this, "Error", QString::fromStdString(message));
}

void UserWindow::displayNextDog() {
    if (m_availableDogs.empty()) {
        QMessageBox::information(this, "No Dogs", "No dogs available to browse.");
        return;
    }
    m_currentDogIndex++;
    updateCurrentDogDisplay();
}

void UserWindow::adoptCurrentDog() {
    if (m_availableDogs.empty()) {
        QMessageBox::information(this, "No Dogs", "No dogs to adopt.");
        return;
    }

    QMessageBox::StandardButton reply;
    reply = QMessageBox::question(this, "Confirm Adoption",
                                  "Are you sure you want to adopt this dog?",
                                  QMessageBox::Yes|QMessageBox::No);
    if (reply == QMessageBox::Yes) {
        try {
            Dog adoptedDog = m_availableDogs[m_currentDogIndex]; // Make a copy before modifying m_availableDogs
            m_service.adopt_dog(adoptedDog);

            // Remove the adopted dog from the current browsing list
            m_availableDogs.erase(m_availableDogs.begin() + m_currentDogIndex);

            // Adjust index if the last dog was adopted
            if (m_currentDogIndex >= m_availableDogs.size() && !m_availableDogs.empty()) {
                m_currentDogIndex = 0; // Wrap around to the first dog if at end
            }

            updateCurrentDogDisplay();
            QMessageBox::information(this, "Adoption Success", "Dog adopted successfully!");
        } catch (const std::exception& e) {
            showErrorMessage(std::string("Failed to adopt dog: ") + e.what());
        }
    }
}

void UserWindow::filterDogsForAdoption() {
    std::string breed = filterBreedInput->text().toStdString();
    int age = filterAgeInput->text().toInt();

    // If age input is empty or invalid, treat as "no max age"
    if (filterAgeInput->text().isEmpty() || age == 0) { // Assuming 0 is not a valid age for filtering "all"
        age = std::numeric_limits<int>::max();
    }

    m_availableDogs = m_service.filter_dogs(breed, age);
    m_currentDogIndex = 0; // Reset index to start of filtered list
    updateCurrentDogDisplay();

    QMessageBox::information(this, "Filter Applied",
                             QString("Found %1 dogs matching your criteria.").arg(m_availableDogs.size()));
}

void UserWindow::viewAdoptionList() {
    try {
        m_service.SaveAdoptedToFile();
        m_service.openAdoptedFile(); // This will try to open the file using the system's default application
    } catch (const std::exception& e) {
        showErrorMessage(std::string("Failed to open adoption file: ") + e.what());
    }
}
