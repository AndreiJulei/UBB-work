#pragma once
typedef int TComp;
typedef TComp TElem;
typedef int TElements;
typedef bool(*Relation)(TComp, TComp);
#define NULL_TCOMP -11111;


struct Node {
	TElem elem;
	Node* next;

	Node(TElem e, Node* n = nullptr) : elem(e), next(n) {}
};


class SortedBagIterator;

class SortedBag {
	friend class SortedBagIterator;

    private:
        Node* head;
        Relation rel;
        int length;

    public:
    	//constructor
	    SortedBag(Relation r); //theta(1)

	    //adds an element to the sorted bag
	    void add(TComp e); //O(n), BC=1 WC=n

	//removes one occurence of an element from a sorted bag
	//returns true if an eleent was removed, false otherwise (if e was not part of the sorted bag)
    	bool remove(TComp e); //O(n), BC=t1 WC=n

	//checks if an element appearch is the sorted bag
	    bool search(TComp e) const; //O(n), BC=theta(1) WC=theta(n)

	//returns the number of occurrences for an element in the sorted bag
	    int nrOccurrences(TComp e) const; //O(n)

	//returns the number of elements from the sorted bag
	    int size() const; //theta(1)

	//returns an iterator for this sorted bag
	    SortedBagIterator iterator() const; //theta(1)

	//checks if the sorted bag is empty
	    bool isEmpty() const; //theta(1)

	//destructor
	    ~SortedBag(); //theta(1)

		void empty();//theta(n)
};

