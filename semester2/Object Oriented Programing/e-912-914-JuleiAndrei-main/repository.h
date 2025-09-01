#pragma once
#include "domain.h"
#include <vector>
#include <string>

class Repository {
    private:
    std::vector<Biologist> biologists;
    std::vector<Bacterium> bacteria;
    
    public:
    void loadBiologists(const std::string& filename);
    void loadBacteria(const std::string& filename);
    void saveBacteria(const std::string& filename);
    void addBacteriumRepo(const Bacterium &b);
    std::vector<Biologist>& getBiologists();
    std::vector<Bacterium>& getBacteria();
};












