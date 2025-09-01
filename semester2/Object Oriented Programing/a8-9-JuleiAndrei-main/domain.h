#pragma once
#include <string>
#include <ostream>

class Dog {
private:
    std::string breed;
    std::string name;
    int age;
    std::string photograph;

public:
    Dog(const std::string& breed = "", const std::string& name = "", int age = 0, const std::string& photograph = "");

    std::string get_breed() const;
    std::string get_name() const;
    int get_age() const;
    std::string get_photo() const;

    void update(const std::string& new_breed, const std::string& new_name, int new_age, const std::string& new_photo);
    bool equals(const Dog& other) const;
    bool operator==(const Dog& other) const;

    std::string toCSV() const;
    std::string toHTML() const;

    friend std::ostream& operator<<(std::ostream& os, const Dog& dog);
};

