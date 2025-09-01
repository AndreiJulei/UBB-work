#include "domain.h"

string Chef :: getName(){
    return name;
}

string Chef :: getCuisineSpeciality(){
    return cuisineSpeciality;
}

string Recipe :: getName(){
    return name;
}
string Recipe::getCuisine(){
    return cuisine;
}
int Recipe :: getPreparationTime(){
    return preparationTime;
}
vector<string> Recipe::getListOfIngredients(){
    return listOfIngredients;
}
