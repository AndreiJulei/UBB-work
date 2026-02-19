#include "Map.h"
#include "MapIterator.h"
#include <exception>
using namespace std;

MapIterator::MapIterator(const Map& d) : map(d) {
    current = map.head;
}

void MapIterator::first() {
    current = map.head;
}

void MapIterator::next() {
    //O(1)
    if (!valid())
        throw exception();
    current = map.next[current];
}

TElem MapIterator::getCurrent() {
    //O(1)
    if (!valid())
        throw exception();
    return map.elements[current];
}

bool MapIterator::valid() const {
    //O(1)
    return current != -1;
}

void MapIterator::previous(){
    //O(1) - bc; O(n) - wc
    if(current == map.head)
        throw exception();

    int prev = -1, ithead;
    ithead = map.head;

    while (ithead !=-1)
    {
        if (map.next[ithead] == current){
            prev = ithead;
            break;
        }
        ithead=map.next[ithead];
    }
    current=prev;
}
