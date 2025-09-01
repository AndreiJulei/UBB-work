#pragma once
#include <vector>
#include "domain.h"

class Repository {
private:
    std::vector<Equation> equations;
public:
    Repository();
    ~Repository() = default;
    void addEquation(Equation& equation);
    void loadFromFile();
    std::vector<Equation> getEquations();
};