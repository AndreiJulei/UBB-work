#include "repository.h"
#include <algorithm>

Repo :: Repo(){
    loadChefs();
    loadRecipes();
    sortRecipesByCuisine();
}

void Repo::loadRecipes(){
    listOfRecipes.clear();
    ifstream fin("Recipes.txt");
    string line;

    while(getline(fin, line)){
        stringstream ss(line);
        string name, cuisine,time;
        vector<string> listIngredients;
        string ingredient;
        getline(ss, name, ',');
        getline(ss, cuisine,','); 
        getline(ss, time, ',');
        while(getline(ss, ingredient,',')) {
            listIngredients.push_back(ingredient);
        }
        listOfRecipes.emplace_back(Recipe(name, cuisine, stoi(time), listIngredients));
    }
}

void Repo::loadChefs(){
    listOfChefs.clear();
    ifstream fin("Chefs.txt");
    string line;

    while(getline(fin, line)){
        stringstream ss(line);
        string name, cuisine;
        getline(ss, name, ',');
        getline(ss, cuisine);
        listOfChefs.emplace_back(Chef(name,cuisine));
    }
}

void Repo::saveRecipes() {
    ofstream fout("Recipes.txt");
    for( auto& t : listOfRecipes) {
        fout << t.getName() << "," << t.getCuisine() << "," << t.getPreparationTime() << ",";
        
        vector <string> ingredients = t.getListOfIngredients();
        for (size_t i = 0; i < ingredients.size(); ++i) {
            fout << ingredients[i];
            if (i != ingredients.size() - 1)
                fout << ","; 
        }
        fout << "\n";
    }
}


bool Repo :: addRecipe(Recipe newRecipe){
    listOfRecipes.push_back(newRecipe);
    saveRecipes();
    notifyObservers();
    return true;
}


vector <Recipe> Repo ::getRecipesByCuisine(string cuisine){
    vector <Recipe> result;
    for(auto r: listOfRecipes){
        if(r.getCuisine() == cuisine){
            result.push_back(r);
        }
    }
    return result;
}


vector <Recipe> Repo::getRecipesByIngredients(vector<string> listIngredients){
    vector<Recipe> result;
    for(auto& r : listOfRecipes){
        bool ok = true;
        for(string& ingredient : listIngredients){
            bool found = false;
            for(auto& recipeIngredient : r.getListOfIngredients()){
                if(ingredient == recipeIngredient){
                    found = true;
                    break;
                }
            }
            if(!found){
                ok = false;
                break;
            }
        }
        if(ok){
            result.push_back(r);
        }
    }
    return result;
}

void Repo::sortRecipesByCuisine() {
    for (int i = 0; i < listOfRecipes.size() - 1; ++i) {
        for (int j = 0; j < listOfRecipes.size() - i - 1; ++j) {
            if (listOfRecipes[j].getCuisine() > listOfRecipes[j + 1].getCuisine()) {
                std::swap(listOfRecipes[j], listOfRecipes[j + 1]);
            }
        }
    }
}
