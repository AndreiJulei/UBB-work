#pragma once
#include "SortedMap.h"
#include <stack>

class SMIterator {
    friend class SortedMap;
private:
    const SortedMap& map;
    std::stack<const SortedMap::Node*> stack;
    
    SMIterator(const SortedMap& mapionar);
    void pushLeft(const SortedMap::Node* node);

public:
    void first();
    void next();
    bool valid() const;
    TElem getCurrent() const;
};