#pragma once
#include "repository.h"

class Service{
    private:
    Repo repo;

    public:
    Service(Repo r): repo(r) {}

    Repo& getRepo() { return repo; }

    vector <Recipe> getRecipes(){
        return repo.getRecipes();
    }
    
    vector <Chef> getChefs(){
        return repo.getChefs();
    }

    bool addRecipeService(string name,int prepTime,vector <string> ingredients, Chef chef);
    vector <Recipe> getRecipesByIngredients(vector <string> ingredients);
    vector <Recipe> getRecipesByCuisine(string cuisine);
};