#include "service.h"

 bool Service :: addRecipeService(string name,int prepTime,vector <string> ingredients, Chef chef){
    for(auto r:repo.getRecipes()){
        if(r.getName() == name){
            return false;
        }
    }
    repo.addRecipe(Recipe(name,chef.getCuisineSpeciality(),prepTime,ingredients));
    return true;
 }
    

vector <Recipe> Service :: getRecipesByIngredients(vector <string> ingredients){
    return repo.getRecipesByIngredients(ingredients);
}
 
 
vector <Recipe> Service ::  getRecipesByCuisine(string cuisine){
    return repo.getRecipesByCuisine(cuisine);
}

