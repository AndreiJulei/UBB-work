#include "repository.h"
#include <fstream>
#include <sstream>

void Repository::loadBiologists(const std::string& filename) {
    biologists.clear();
    std::ifstream fin(filename);
    std::string line;
    while (getline(fin, line)) {
        std::stringstream ss(line);
        std::string name, species;
        std::vector<std::string> speciesStudied;
        getline(ss, name, ',');
        while (getline(ss, species, ',')) speciesStudied.push_back(species);
        biologists.emplace_back(name, speciesStudied);
    }
}

void Repository::loadBacteria(const std::string& filename) {
    bacteria.clear();
    std::ifstream fin(filename);
    std::string line;
    while (getline(fin, line)) {
        std::stringstream ss(line);
        std::string name, species, sizeStr, disease;
        std::vector<std::string> diseases;
        getline(ss, name, ',');
        getline(ss, species, ',');
        getline(ss, sizeStr, ',');
        while (getline(ss, disease, ',')) diseases.push_back(disease);
        bacteria.emplace_back(name, species, stoi(sizeStr), diseases);
    }
}

void Repository::saveBacteria(const std::string& filename) {
    std::ofstream fout(filename);
    for (const auto& b : bacteria) {
        fout << b.getName() << "," << b.getSpecies() << "," << b.getSize();
        for (const auto& d : b.getDiseases()) fout << "," << d;
        fout << "\n";
    }
}

std::vector<Biologist>& Repository::getBiologists() { 
    return biologists; 
}

std::vector<Bacterium>& Repository::getBacteria() { 
    return bacteria;
}

void Repository::addBacteriumRepo(const Bacterium &b){
    bacteria.push_back(b);
}