#pragma once
#include <utility>
#include <exception>

typedef int TKey;
typedef int TValue;
typedef std::pair<TKey, TValue> TElem;
#define NULL_TVALUE -111111
#define NULL_TPAIR std::pair<TKey, TValue>(-111111, -111111)

class SMIterator;

typedef bool(*Relation)(TKey, TKey);

class SortedMap {
    friend class SMIterator;
private:
    // Representation of the BST
    struct Node {
        TElem element;
        Node* left;
        Node* right;
    };
    Node* root;
    int mapSize;
    Relation relation;

public:
    // implicit constructor
    SortedMap(Relation r);

    // adds a pair (key,value) to the map
    TValue add(TKey c, TValue v);

    // searches for the key and returns the value associated with the key if the map contains the key or null: NULL_TVALUE otherwise
    TValue search(TKey c) const;

    // removes a key from the map and returns the value associated with the key if the key existed or null: NULL_TVALUE otherwise
    TValue remove(TKey c);

    // returns the number of pairs (key,value) from the map
    int size() const;

    // checks whether the map is empty or not
    bool isEmpty() const;

    // return the iterator for the map
    SMIterator iterator() const;

    // destructor
    ~SortedMap();
};