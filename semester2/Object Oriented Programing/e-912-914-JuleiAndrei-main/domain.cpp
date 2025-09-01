#include "domain.h"

Bacterium::Bacterium(const std::string& name, const std::string& species, int size, const std::vector<std::string>& diseases)
    : name(name), species(species), size(size), diseases(diseases) {}

std::string Bacterium::getName() const { 
    return name; 
}
std::string Bacterium::getSpecies() const { 
    return species; 
}
int Bacterium::getSize() const { 
    return size; 
}
const std::vector<std::string>& Bacterium::getDiseases() const { 
    return diseases; 
}
void Bacterium::addDisease(const std::string& disease) { 
    diseases.push_back(disease); 
}


Biologist::Biologist(const std::string& name, const std::vector<std::string>& speciesStudied)
    : name(name), speciesStudied(speciesStudied) {}

std::string Biologist::getName() const { 
    return name; 
}
const std::vector<std::string>& Biologist::getSpeciesStudied() const { 
    return speciesStudied; 
}