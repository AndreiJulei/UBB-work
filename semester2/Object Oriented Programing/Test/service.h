#pragma once
#include "repo.h"

class Service {
private:
    Repository& repository;
public:
    Service(Repository& repo) : repository(repo) {}
    ~Service() = default;
    std::vector<Equation> getEquations();
    void addEquation(double a, double b, double c);
};