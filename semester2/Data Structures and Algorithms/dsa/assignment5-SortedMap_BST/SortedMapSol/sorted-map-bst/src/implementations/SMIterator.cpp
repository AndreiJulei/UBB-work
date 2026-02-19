#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>

using namespace std;

SMIterator::SMIterator(const SortedMap& m) : map(m) {
    first();
}

void SMIterator::pushLeft(const SortedMap::Node* node) {
    while (node != nullptr) {
        stack.push(node);
        node = node->left;
    }
}

void SMIterator::first() {
    while (!stack.empty()) {
        stack.pop();
    }
    pushLeft(map.root);
}

void SMIterator::next() {
    if (!valid()) {
        throw std::exception();
    }
    
    const SortedMap::Node* current = stack.top();
    stack.pop();
    
    if (current->right != nullptr) {
        pushLeft(current->right);
    }
}

bool SMIterator::valid() const {
    return !stack.empty();
}

TElem SMIterator::getCurrent() const {
    if (!valid()) {
        throw std::exception();
    }
    return stack.top()->element;
}