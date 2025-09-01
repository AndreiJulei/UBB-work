#pragma once
#include <stdexcept>
#include <string>

class ValidationException : public std::runtime_error {
public:
    ValidationException(const std::string& msg) : std::runtime_error(msg) {}
};

class RepositoryException : public std::runtime_error {
public:
    RepositoryException(const std::string& msg) : std::runtime_error(msg) {}
};

