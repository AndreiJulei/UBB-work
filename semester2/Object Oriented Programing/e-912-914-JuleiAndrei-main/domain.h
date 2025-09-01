#pragma once
#include <string>
#include <vector>

class Bacterium {
    private:
    std::string name;
    std::string species;
    int size;
    std::vector<std::string> diseases;
    
    public:
    Bacterium(const std::string& name, const std::string& species, int size, const std::vector<std::string>& diseases);
    std::string getName() const;
    std::string getSpecies() const;
    int getSize() const;
    const std::vector<std::string>& getDiseases() const;
    void addDisease(const std::string& disease);
};

class Biologist {
    private:
    std::string name;
    std::vector<std::string> speciesStudied;
    
    public:
    Biologist(const std::string& name, const std::vector<std::string>& speciesStudied);
    std::string getName() const;
    const std::vector<std::string>& getSpeciesStudied() const;
};