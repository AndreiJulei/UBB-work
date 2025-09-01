#pragma once
#include "domain.h"
#include <vector>


class Repo{

    private:

    std :: vector <Protein> proteins;


    public:

    void add(Protein p){
        proteins.push_back(p);
    }

    std :: vector <Protein> get_all(){
        return proteins;
    }

    void remove(int index){
        for (int i=index; i<proteins.size()-1; i++)
            proteins[i]=proteins[i+1];
    }

    int length(){
        return proteins.size();
    }



};