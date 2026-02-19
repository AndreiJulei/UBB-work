#include "SMIterator.h"
#include "SortedMap.h"
#include <exception>
using namespace std;

SortedMap::SortedMap(Relation r) {
    this->root = nullptr;
    this->relation = r;
    this->mapSize = 0;
}

TValue SortedMap::add(TKey k, TValue v) {
    Node* newNode = new Node{{k, v}, nullptr, nullptr};
    
    if (root == nullptr) {
        root = newNode;
        mapSize++;
        return NULL_TVALUE;
    }
    
    Node* current = root;
    Node* parent = nullptr;
    
    while (current != nullptr) {
        if (current->element.first == k) {
            TValue oldValue = current->element.second;
            current->element.second = v;
            delete newNode;
            return oldValue;
        }
        
        parent = current;
        if (relation(k, current->element.first)) {
            current = current->left;
        } else {
            current = current->right;
        }
    }
    
    if (relation(k, parent->element.first)) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }
    
    mapSize++;
    return NULL_TVALUE;
}

TValue SortedMap::search(TKey k) const {
    Node* current = root;
    
    while (current != nullptr) {
        if (current->element.first == k) {
            return current->element.second;
        }
        
        if (relation(k, current->element.first)) {
            current = current->left;
        } else {
            current = current->right;
        }
    }
    
    return NULL_TVALUE;
}

TValue SortedMap::remove(TKey k) {
    Node* current = root;
    Node* parent = nullptr;
    bool isLeftChild = true;
    
    while (current != nullptr && current->element.first != k) {
        parent = current;
        if (relation(k, current->element.first)) {
            current = current->left;
            isLeftChild = true;
        } else {
            current = current->right;
            isLeftChild = false;
        }
    }
    
    if (current == nullptr) {
        return NULL_TVALUE;
    }
    
    TValue oldValue = current->element.second;
    
    // Case 1: Node has no children
    if (current->left == nullptr && current->right == nullptr) {
        if (current == root) {
            root = nullptr;
        } else if (isLeftChild) {
            parent->left = nullptr;
        } else {
            parent->right = nullptr;
        }
        delete current;
    }
    // Case 2: Node has only right child
    else if (current->left == nullptr) {
        if (current == root) {
            root = current->right;
        } else if (isLeftChild) {
            parent->left = current->right;
        } else {
            parent->right = current->right;
        }
        delete current;
    }
    
    // Case 3: Node has only left child
    else if (current->right == nullptr) {
        if (current == root) {
            root = current->left;
        } else if (isLeftChild) {
            parent->left = current->left;
        } else {
            parent->right = current->left;
        }
        delete current;
    }
    // Case 4: Node has two children
    else {
        Node* successor = current->right;
        Node* successorParent = current;
        
        while (successor->left != nullptr) {
            successorParent = successor;
            successor = successor->left;
        }
        
        current->element = successor->element;
        
        if (successorParent == current) {
            successorParent->right = successor->right;
        } else {
            successorParent->left = successor->right;
        }
        
        delete successor;
    }
    
    mapSize--;
    return oldValue;
}

int SortedMap::size() const {
    return mapSize;
}

bool SortedMap::isEmpty() const {
    return mapSize == 0;
}

SortedMap::~SortedMap() {
    while (!isEmpty()) {
        remove(root->element.first);
    }
}