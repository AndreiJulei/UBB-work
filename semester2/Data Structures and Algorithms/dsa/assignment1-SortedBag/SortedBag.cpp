#include <cmath>
#include "SortedBag.h"
#include "SortedBagIterator.h"

SortedBag::SortedBag(Relation r) {

	this ->relation = r;
	this -> bagSize = 0;
	this -> bagCapacity = 100;
	this -> elements = new TComp[this->bagCapacity];
}


void SortedBag::add(TComp e) {
	/*
	O(n), BC=1 WC=n	
	*/
	if (this -> bagSize+1 == this -> bagCapacity)
	{
		this->bagCapacity *= 2;  
        TComp* newElements = new TComp[this->bagCapacity];
        for (int i = 0; i < this->bagSize; i++) {
            newElements[i] = this->elements[i];
        }
        delete[] this->elements;
        this->elements = newElements;
	}
	int index = 0;
    while (index < this->bagSize && this->relation(this->elements[index], e)) {
        index++;
    }

    for (int i = this->bagSize; i > index; i--) {
        this->elements[i] = this->elements[i - 1];
    }

    this->elements[index] = e;

    this->bagSize++;	
}


bool SortedBag::remove(TComp e) {
	/*
	O(n), BC=1 WC=n
	*/
	int index=0;
	while (index < this->bagSize)
	{
		if (this->elements[index] == e)
			break;
		index++;
	}

	if (index == this -> bagSize)
		return false;

	for (int i=index;i<bagSize-1;i++)
		this->elements[i] = this->elements[i+1];
	this -> bagSize --;

	return true;
}


bool SortedBag::search(TComp elem) const {
	//O(log2(n)), BC=theta(1) WC=theta(log2(n))
	int left=0,right=this->bagSize-1;
	while (left<=right)
	{
		int mid=(left+right)/2;
		if (this->elements[mid] == elem)
			return true;
		else if(this->relation(this->elements[mid], elem))
			left=mid+1;
		else
			right = mid-1;
	}
	return false;
}


int SortedBag::nrOccurrences(TComp elem) const {
	/*
	O(sqrt(n)), BC=1, WC(O(n))
	*/
	int index=0,cnt=0,jmp;
	jmp=sqrt(this->bagSize);
	while (index < this->bagSize)
	{
		if (!(this->relation(this->elements[index],elem)))
		{	index=index-jmp;
			break;
		}
		index+=jmp;
	}

	for (int i=index; i<index+jmp; i++)
		if (this->elements[i] == elem)
			cnt++;
	
	return cnt;
}


int SortedBag::size() const {
	//theta(1)
	return bagSize;
}


bool SortedBag::isEmpty() const {
	//theta(1)
	return bagSize == 0;
}


SortedBagIterator SortedBag::iterator() const {
	//theta(1)
	return SortedBagIterator(*this);
}


SortedBag::~SortedBag() {
	//theta(1)
	delete[] this->elements;

}
