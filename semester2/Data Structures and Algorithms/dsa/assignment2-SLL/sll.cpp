#include "sll.h"
#include "sllitterator.h"


SortedBag::SortedBag(Relation r) {
    this->head = nullptr;
    this->rel = r;
    this->length = 0;
}


void SortedBag::add(TComp e) {
    Node* newNode = new Node(e);

    if (head == nullptr || rel(e, head->elem)) {
        newNode->next = head;
        head = newNode;
    } else {

        Node* current = head;
        Node* previous = nullptr;

        while (current != nullptr && !rel(e, current->elem)) {
            previous = current;
            current = current->next;
        }


        previous->next = newNode;
        newNode->next = current;
    }

    length++;
}


bool SortedBag::remove(TComp e) {
    Node* current = head;
    Node* previous = nullptr;

    while (current != nullptr) {

        if (current->elem == e) {
        
            if (previous == nullptr) {// elem is at head
                
                head = current->next;

            } else {

                previous->next = current->next;

            }
        
            delete current;
            length--;
            return true;
        }
        
        previous = current;
        current = current->next;
    }

    return false;
}

bool SortedBag:: search(TComp e) const{
    Node* current=head;

    while (current!=nullptr)
    {
        if (current->elem==e)
            return true;
        current=current->next;
    }
    return false;

}

int SortedBag:: nrOccurrences(TComp e) const{
    int nr_occurences=0;
    Node* current=head;

    while (current!=nullptr)
    {
        if (current->elem==e)
            nr_occurences++;
        current=current->next;

    }
    return nr_occurences;
}


int SortedBag:: size() const{
    return this->length;
}


bool SortedBag ::isEmpty() const{
    return length==0;
}

SortedBagIterator SortedBag::iterator() const {
    return SortedBagIterator(*this);
}


SortedBag::~SortedBag() {
    Node* current = head;
    while (current != nullptr) {
        Node* next = current->next;
        delete current;
        current = next;
    }
}


void SortedBag::empty() {
    Node* current = head;
    Node* next=nullptr;

    while (current != nullptr) {    
        next = current->next;
        delete current;
        current = next;
    }
    
    delete next;
    head = nullptr;
    length = 0;
}
