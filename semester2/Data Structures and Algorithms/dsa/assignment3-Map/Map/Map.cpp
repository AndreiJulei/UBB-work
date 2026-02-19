#include "Map.h"
#include "MapIterator.h"
#include <exception>


Map::Map() {
	capacity = 10;
    elements = new TElem[capacity];
    next = new int[capacity];

    for (int i = 0; i < capacity - 1; i++)
        next[i] = i + 1;
    next[capacity - 1] = -1;

    head = -1;
    firstFree = 0;
    currentSize = 0;
}



Map::~Map() {
    delete[] elements;
    delete[] next;
}



int Map::allocate() {
    if (firstFree == -1) {
        resize();
    }

    int newElem = firstFree;
    firstFree = next[firstFree];
    return newElem;
}



void Map::deallocate(int pos) {
    next[pos] = firstFree;
    firstFree = pos;
}



void Map :: resize(){
	int newCapacity = 2 * capacity;
    TElem* newElements = new TElem[newCapacity];
    int* newNext = new int[newCapacity];

    for (int i = 0; i < capacity; i++) {
        newElements[i] = elements[i];
        newNext[i] = next[i];
    }

    for (int i = capacity; i < newCapacity - 1; i++) {
        newNext[i] = i + 1;
    }
    newNext[newCapacity - 1] = -1;

    delete[] elements;
    delete[] next;

    elements = newElements;
    next = newNext;
    firstFree = capacity;
    capacity = newCapacity;
}



TValue Map::add(TKey c, TValue v){
    //O(n)
	int current = head;
    while (current != -1) {
        if (elements[current].first == c) {
            TValue old = elements[current].second;
            elements[current].second = v;
            return old;
        }
        current = next[current];
    }

    int newElem = allocate();
    elements[newElem] = TElem(c, v);
    next[newElem] = head;
    head = newElem;
    currentSize++;
    return NULL_TVALUE;
}

TValue Map::search(TKey c) const{
        //O(1) - bc; O(n) - wc
	int current = head;
	while (current!=-1)
	{
		if (elements[current].first == c){
			return elements[current].second;
		}
		current=next[current];
	}
	return NULL_TVALUE;
}

TValue Map::remove(TKey c){
        //O(1) - bc; O(n) - wc
	int current=head;
	int previous=-1;


	while (current != -1 && elements[current].first != c){
		previous=current;
		current=next[current];
	}

	if (current == -1) {
        return NULL_TVALUE;
    }

	TValue removed_value = elements[current].second;

	if (previous == -1){
		head=next[current];
	}
	else{
		next[previous] = next[current];
	}
	
	deallocate(current);
	currentSize--;
	return removed_value;
}


int Map::size() const {
    //O(1)
	return currentSize;
}

bool Map::isEmpty() const{
	//O(1)
	return currentSize==0;
}

MapIterator Map::iterator() const {
	return MapIterator(*this);
}



