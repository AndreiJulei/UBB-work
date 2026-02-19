#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>
#include <iostream> 
#include <map>
using namespace std;

int SortedMap::hashFunction(TKey key) const {
    //theta(1)
    return abs(key) % capacity;
}

SortedMap::SortedMap(Relation r) : relation(r), capacity(10), currentSize(0) {
    //theta(1)
	table = new Node*[capacity]();
}


TValue SortedMap::add(TKey k, TValue v) {
    //best case-> O(1) | worst case-> O(n)
    int bucket = hashFunction(k);
    Node* current = table[bucket];
    Node* previous = nullptr;
    TValue oldValue = NULL_TVALUE;

    while (current != nullptr) {
        if (current->data.first == k) {
            oldValue = current->data.second;
            current->data.second = v;
            return oldValue;
        }
        previous = current;
        current = current->next;
    }

    Node* newNode = new Node({k, v});
    newNode->next = table[bucket];
    table[bucket] = newNode;
    currentSize++;
    return NULL_TVALUE; 
}


TValue SortedMap::search(TKey k) const {
    //best case-> O(1) | worst case-> O(n)
    int bucket = hashFunction(k);
    Node* current = table[bucket];

    while (current != nullptr) {
        if (current->data.first == k) {
            return current->data.second;
        }
        current = current->next;
    }

    return NULL_TVALUE;
}

TValue SortedMap::remove(TKey k) {
    //best case-> O(1) | worst case-> O(n)
    int bucket = hashFunction(k);
    Node* current = table[bucket];
    Node* previous = nullptr;
    TValue removedValue = NULL_TVALUE;

    while (current != nullptr) {
        if (current->data.first == k) {
            if (previous == nullptr) {
                table[bucket] = current->next;
            } else {
                previous->next = current->next;
            }

            delete current;
            currentSize--;
            return removedValue;
        }
        previous = current;
        current = current->next;
    }

    return NULL_TVALUE;
}

int SortedMap::size() const {
    //theta(1)
    return currentSize;
}

bool SortedMap::isEmpty() const {
    //theta(1)
    return currentSize == 0;
}

SMIterator SortedMap::iterator() const {
    //theta(1)
	return SMIterator(*this);
}

SortedMap::~SortedMap() {
    //O(n)
	for (int i = 0; i < capacity; ++i) {
		Node* current = table[i];
		while (current != nullptr) {
			Node* next = current->next;
			delete current;
			current = next;
		}
	}
	delete[] table;
}

/*
TValue SortedMap :: mostFrequent() const{

    if (currentSize == 0)
        return NULL_TVALUE;

    int maxFrequency=0;
    TValue maxValue;
    
    for (int i = 0; i < capacity; ++i) {
        Node* current = table[i];

        int presentFrequency=1;
        Node*next=current->next;
        while (next!=nullptr)
        {   
            if (next->data == current->data)
                presentFrequency++;

            next=next->next;
        }

        if (presentFrequency >= maxFrequency)
        {
            maxFrequency = presentFrequency;
            maxValue = current->data.second;
        }
    }
    
    return maxValue;
}*/