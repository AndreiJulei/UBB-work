#pragma once
#include "sll.h"

class SortedBagIterator {

    friend class SortedBag;

private:
    const SortedBag& bag;
    Node* current; 
    SortedBagIterator(const SortedBag& b);

public:
    TComp getCurrent();     // theta(1)
    bool valid();           // theta(1)
    void next();            // theta(1)
    void first();           // theta(1)
};
