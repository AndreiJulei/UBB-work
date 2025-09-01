#include "repo.h"

#include <fstream>

Repository::Repository() {
    loadFromFile();
}

void Repository::addEquation(Equation &equation) {
    equations.push_back(equation);
}

void Repository::loadFromFile() {
    std::ifstream file("../equations.txt");
    if (!file.is_open()) {
        throw std::runtime_error("Could not open file");
    }

    double a, b, c;
    char comma1, comma2;
    while (file >> a >> comma1 >> b >> comma2 >> c) {
        if (comma1 == ',' && comma2 == ',') {
            equations.emplace_back(a, b, c);
        }
    }

    file.close();
}

std::vector<Equation> Repository::getEquations() {
    return equations;
}