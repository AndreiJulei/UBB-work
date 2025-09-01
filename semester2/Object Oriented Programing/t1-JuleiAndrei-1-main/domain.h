#pragma once
#include <iostream>
#include <string>

class Protein{

    private:
    std :: string organism;
    std :: string name;
    std :: string associated_sequence;


    public:

    Protein( std :: string organism,  std :: string name,  std :: string associated_sequence):
    organism(organism),name(name),associated_sequence(associated_sequence){}

    std :: string get_name(){ 
        return this->name;
    }

    std :: string get_organism(){

        return this->organism;
    }

    std :: string get_sequence(){
        return this->associated_sequence;
    }



};