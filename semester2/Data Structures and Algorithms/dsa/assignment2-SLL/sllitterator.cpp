#include "sllitterator.h"
#include "sll.h"
#include <exception>

using namespace std;

SortedBagIterator::SortedBagIterator(const SortedBag& b) : bag(b) {
    current = bag.head;
}

TComp SortedBagIterator::getCurrent() {
    if (!valid()) {
        throw std::exception();
    }
    return current->elem;
}

bool SortedBagIterator::valid() {
    return current != nullptr;
}

void SortedBagIterator::next() {
    if (!valid()) {
        throw std::exception();
    }
    current = current->next;
}

void SortedBagIterator::first() {
    current = bag.head;
}
