#pragma once

class Equation {
private:
    double a,b,c;
public:
    Equation(double a, double b, double c): a(a), b(b), c(c) {}
    ~Equation() = default;
    double getA();
    double getB();
    double getC();
};