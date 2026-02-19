#include "SMIterator.h"
#include <exception>
#include <vector>
using namespace std;

SMIterator::SMIterator(const SortedMap& m) : map(m), currentBucket(0), currentNode(nullptr), currentIndex(0) {
    //O(n^2)
    for (int i = 0; i < map.capacity; ++i) {
        SortedMap::Node* current = map.table[i];
        while (current != nullptr) {
            sortedElements.push_back(current->data);
            current = current->next;
        }
    }
    int n = sortedElements.size();
    for (int i = 0; i < n - 1; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (!map.relation(sortedElements[j].first, sortedElements[j+1].first)) {
                TElem temp = sortedElements[j];
                sortedElements[j] = sortedElements[j+1];
                sortedElements[j+1] = temp;
            }
        }
    }
    first();
}

void SMIterator::first(){
    //theta(1)
    currentIndex = 0;
}

void SMIterator::next(){
    //theta(1)
    if (!valid()) {
        throw std::exception();
    }
    currentIndex++;
}
bool SMIterator::valid() const{
    //theta(1)
    return currentIndex < sortedElements.size();
}

TElem SMIterator::getCurrent() const{
    //theta(1)
    if (!valid()) {
        throw std::exception();
    }
    return sortedElements[currentIndex];
}
