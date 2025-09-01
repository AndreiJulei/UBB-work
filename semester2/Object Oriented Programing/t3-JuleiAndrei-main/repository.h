#pragma once
#include "domain.h"


class Repo{

    private:
    std :: vector <Meal> meals;

    public:

    Repo(std::vector<Meal> meals) : meals(meals){}

    void addMeal(Meal m){
        meals.push_back(m);
    }
    
    std:: vector <Meal> getMeals(){
        return meals;
    }

    std:: vector <Meal> filterList(int calories){
        std:: vector <Meal> filteredlist;

        for (auto &m: meals){
            if (m.getCalories()<=calories){
                filteredlist.push_back(m);
            }
        }
        return filteredlist;
    }

    std:: vector <Meal> mealTypeFilter(std::string mtype,int startHour){
        std:: vector <Meal> filteredlist;

        for (auto &m: meals){
            if (m.getMealType() == mtype , m.getStart()<=startHour && m.getEnd() >=startHour){
                filteredlist.push_back(m);
            }
        }
        return filteredlist;
    }


};