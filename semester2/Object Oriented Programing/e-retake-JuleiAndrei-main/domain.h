#pragma once
#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Chef{

    private:
    string name,cuisineSpeciality;

    public:
    Chef(string n, string cuisine): name(n), cuisineSpeciality(cuisine) {}

    string getName();
    string getCuisineSpeciality();

};

class Recipe{

    private:
    string name,cuisine;
    int preparationTime;
    vector <string> listOfIngredients;

    public:
   Recipe(string n, string cuisine, int time, vector <string> ingredients) : name(n), cuisine(cuisine), preparationTime(time), listOfIngredients(ingredients) {}

   string getName();
   string getCuisine();
   int getPreparationTime();
   vector<string> getListOfIngredients();

};