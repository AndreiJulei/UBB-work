#pragma once
#include "repository.h"

class Services{

    private:
    Repo &repo;

    public:
    void add_serv(Protein p){
        /*
        Adds a protein to the repository
        :params: p
        return: none
        */
        repo.add(p);
    }

    int remove_service(std :: string name,std :: string organism){
        /*
        removes a protein from the repository
        :params: p
        return: 1/0
        */
        std :: vector <Protein> list = repo.get_all();
        for(int i=0;i< list.size(); i++)
        {
            if (list[i].get_name() == name && list[i].get_organism() == organism){
                repo.remove(i);
                return 1;
            }
        }
        return 0;
    }


    std :: vector <Protein> get_all_service(){
        return repo.get_all();
    }

    std :: vector <Protein> sort_sequence(std :: vector <Protein> &list){
        /*
        Sorts and returns a vector of proteins
        :params: vector of proteins
        return: sorted vector
        */
        for(int i=0; i<list.size()-1; i++)
            for(int j=i+1; j<list.size(); i++)
            if(list[i].get_name()> list[j].get_name())
            {
                Protein p=list[j];
                list[j]=list[i];
                list[i]=p;
            } 
            return list;
    }

    std :: vector <Protein> get_sequence_service(std :: string user_sequence){
        /*
        Finds the proteins with a given string
        :params: string
        return: list of searched proteins
        */
        std :: vector <Protein> list =repo.get_all();
        std :: vector <Protein> list_of_proteins;

        for (int i=0; i<list.size(); i++){
            if (list[i].get_name().find(user_sequence))
            list_of_proteins.push_back(list[i]);
        }
        
        return sort_sequence(list_of_proteins);
    }

};