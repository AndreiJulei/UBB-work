#pragma once
#include "services.h"

class UI{

    private:
    Services &serv;

    public:

    void remove_ui(){
        std :: string name,organism;
        std :: cout << "Enter name and organism: ";
        std :: cin >> name >> organism;
        int state=serv.remove_service(name,organism);
        if (state){
            std :: cout << "Protein removed succesfully!\n";
        }
        else {
            std :: cout << "There are no proteins with the given name/organism\n";
        }
    }

    void print_proteins(std :: vector <Protein> list){
        for (int i=0;i<list.size(); i++){
            std :: cout << list[i].get_organism() << " | " << list[i].get_name() << " | " << list[i].get_sequence()<< "\n";
        }
    }

    void search_ui(){
        std :: string user_sequence;
        std :: cout << "Enter sequence of protein you want to find: ";
        std :: cin >> user_sequence;

        std :: vector <Protein> list=serv.get_sequence_service(user_sequence);
        if(list.size()==0){
            std :: cout << "There are no proteins with the given string\n";
        }
        else{
            print_proteins(list);
        }

    }

    void add_ui(){
        serv.add_serv(Protein("Human","Myosin-2","MSS"));
        serv.add_serv(Protein("Human","Keratin","TCGSG"));
        serv.add_serv(Protein("Mouse","keratin","MLW"));
    }

    void run_ui(){

        int choise;
        
        while (true)
        {
            std :: cout << "1.Remove a protein\n 2.Show all proteins\n 3.Search for protein\n 4.Exit\n";
            std :: cout << "Choose an option: ";
            std :: cin >> choise;

            if (choise == 1){
                remove_ui();
            } else if (choise == 2){
                print_proteins(serv.get_all_service());
            } else if (choise == 3){
                search_ui();
            } else if (choise == 4){
                break;
            }

        }
        



    }  

};