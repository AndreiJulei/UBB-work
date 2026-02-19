#include "SortedBagIterator.h"
#include "SortedBag.h"
#include <exception>

using namespace std;

SortedBagIterator::SortedBagIterator(const SortedBag& b) : bag(b) {
	this->index = 0;
}

TComp SortedBagIterator::getCurrent() {

	if (this -> index < 0 || this -> index >= this -> bag.bagSize)
		throw exception();
	return this -> bag.elements[this -> index];
}

bool SortedBagIterator::valid() {
	if (this -> index < this -> bag.bagSize && this -> index >= 0)
		return true;
	return false;
}

void SortedBagIterator::next() {
	if (!this -> valid())
		throw exception();
	this -> index++;
}

void SortedBagIterator::first() {
	this -> index = 0;
}



