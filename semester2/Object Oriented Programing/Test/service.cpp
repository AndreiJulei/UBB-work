#include "service.h"

std::vector<Equation> Service::getEquations() {
    return repository.getEquations();
}

void Service::addEquation(double a, double b, double c) {
    Equation equation(a, b, c);
    repository.addEquation(equation);
}