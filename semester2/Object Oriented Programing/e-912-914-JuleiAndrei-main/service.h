#pragma once
#include "repository.h"
#include "domain.h" 
#include <vector>
#include <string>
#include <QObject> 

class Service : public QObject { // Inherit from QObject
    Q_OBJECT // Macro for Qt's meta-object system

private:
    Repository& repo;

public:
    Service(Repository& repo);
    std::vector<Biologist>& getBiologists();
    std::vector<Bacterium> getBacteriaForBiologist(const Biologist& bio);
    std::vector<std::string> getSpecies();
    std::vector<Bacterium> getBacteriaBySpecies(const std::string& species);
    void addBacterium(const Bacterium& b);
    void addDiseaseToBacterium(const std::string& bacteriumName, const std::string& disease);
    void saveAll(const std::string& filename);

signals:
    // Signal emitted when the list of bacteria or their properties change
    void bacteriaListChanged();
};