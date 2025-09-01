#pragma once
#include "dynamicvector.h"
#include <vector>
#include <string>

class Service {
private:
    DynamicVector repo;
    std::vector<Dog> adoption_list;
    std::string fileType; // "csv" or "html"

public:
    Service(const std::string& fileType) : fileType(fileType) {}

    void add_dog(const Dog& dog);
    void remove_dog(const Dog& dog);
    void update_dog(const Dog& old_dog, const Dog& new_dog);
    void view_all() const;
    std::vector<Dog> get_all_dogs() const;
    std::vector<Dog> filter_dogs(const std::string& breed, int age) const;
    void adopt_dog(const Dog& dog);
    const std::vector<Dog>& get_adoption_list() const;
    void SaveAdoptedToFile();
    void openAdoptedFile();
};

