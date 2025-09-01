// dynamicvector.h
#pragma once
#include <vector>
#include <string>
#include <fstream>
#include "domain.h"
#include "validators.h" // Include validator

class DynamicVector {
private:
    std::vector<Dog> dogs;
    std::string file_path = "dogs.txt"; // Default file path
    Validator validator; // Validator instance

    void load_from_file();
    void save_to_file() const;

public:
    DynamicVector(); // Constructor no longer takes a validator directly

    void add(const Dog& dog);
    void remove(const Dog& dog);
    void update(const Dog& old_dog, const Dog& new_dog);
    int length() const;
    Dog& get(int index);
    std::vector<Dog> get_all() const;
    std::vector<Dog> filter(const std::string& breed, int max_age) const;
};
