#include "service.h"
#include <set>
#include <algorithm> // For std::sort (if needed for getSpecies, though set already sorts)

Service::Service(Repository& repo) : QObject(), repo(repo) {} // Initialize QObject base class

std::vector<Biologist>& Service::getBiologists() {
    return repo.getBiologists();
}

std::vector<Bacterium> Service::getBacteriaForBiologist(const Biologist& bio) {
    std::vector<Bacterium> result;
    for (const auto& b : repo.getBacteria()) {
        for (const auto& s : bio.getSpeciesStudied()) {
            if (b.getSpecies() == s) {
                result.push_back(b);
            }
        }
    }
    // Optionally sort the result
    return result;
}

std::vector<std::string> Service::getSpecies() {
    std::set<std::string> species;
    for (const auto& b : repo.getBacteria()) {
        species.insert(b.getSpecies());
    }
    std::vector<std::string> sortedSpecies(species.begin(), species.end());
    // std::set already keeps elements sorted, so std::sort is technically redundant here
    // std::sort(sortedSpecies.begin(), sortedSpecies.end());
    return sortedSpecies;
}

std::vector<Bacterium> Service::getBacteriaBySpecies(const std::string& species) {
    std::vector<Bacterium> result;
    for (const auto& b : repo.getBacteria()) {
        if (b.getSpecies() == species) {
            result.push_back(b);
        }
    }
    return result;
}

void Service::addDiseaseToBacterium(const std::string& bacteriumName, const std::string& disease) {
    bool modified = false;
    for (auto& b : repo.getBacteria()) {
        if (b.getName() == bacteriumName) {
            b.addDisease(disease);
            modified = true;
            break; // Assuming bacterium names are unique within the repository for modification
        }
    }
    if (modified) {
        emit bacteriaListChanged(); // Emit signal if a modification occurred
    }
}

void Service::saveAll(const std::string& filename){
    repo.saveBacteria(filename);
}

void Service::addBacterium(const Bacterium &b){
    repo.addBacteriumRepo(b); // Assuming repo.addBacteriumRepo is the correct method to add to the repository
    emit bacteriaListChanged(); // Emit signal after adding a new bacterium
}