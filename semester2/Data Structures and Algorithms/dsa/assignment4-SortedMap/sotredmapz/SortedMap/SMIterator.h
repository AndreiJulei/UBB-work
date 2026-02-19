#pragma once
#include <iostream>
#include <vector>
#include "SortedMap.h"

//DO NOT CHANGE THIS PART
class SMIterator{
	friend class SortedMap;
private:
	const SortedMap& map;
	SMIterator(const SortedMap& mapionar);

    //TODO - Representation
    int currentBucket; // The current bucket index in the hash table
    SortedMap::Node* currentNode; // The current node in the linked list of the current bucket
    std::vector<TElem> sortedElements; // Store elements in sorted order for iteration
    int currentIndex; // Index for iterating through the sorted elements

	
public:
	void first();
	void next();
	bool valid() const;
    TElem getCurrent() const;
};

