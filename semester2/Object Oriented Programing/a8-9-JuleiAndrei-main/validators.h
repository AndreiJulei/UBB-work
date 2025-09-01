#pragma once
#include "domain.h"
#include "exceptions.h"

class Validator {
public:
    void validate(Dog dog) {
        if (dog.get_name().empty() || dog.get_breed().empty() || dog.get_photo().empty())
            throw ValidationException("Fields cannot be empty!");

        if (dog.get_age() <= 0)
            throw ValidationException("Age must be >= 0");
    }
};

