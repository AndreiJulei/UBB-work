#pragma once
#include "SortedBag.h"

class SortedBag;

class SortedBagIterator
{
	friend class SortedBag;

private:
	const SortedBag& bag;
	SortedBagIterator(const SortedBag& b);
	int index;

public:
	TComp getCurrent(); //theta(1)
	bool valid();		//theta(1)
	void next();		//theta(1)
	void first();		//theta(1)
};

