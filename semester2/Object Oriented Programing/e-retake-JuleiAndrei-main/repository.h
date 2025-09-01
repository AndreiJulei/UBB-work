#pragma once
#include <fstream>
#include <sstream>
#include "observer.h"
#include "domain.h"

class Repo : public Subject {

    private:
    vector <Recipe> listOfRecipes;
    vector <Chef> listOfChefs;

    public:
    Repo();

    void loadChefs();
    void loadRecipes();
    void saveRecipes();

    vector <Recipe> getRecipes(){
        sortRecipesByCuisine();
        return listOfRecipes;
    }
    
    vector <Chef> getChefs(){
        return listOfChefs;
    }

    void sortRecipesByCuisine();

    vector <Recipe> getRecipesByIngredients(vector<string> listIngredients);
    vector <Recipe> getRecipesByCuisine(string cuisine);
    bool addRecipe(Recipe newRecipe);
};