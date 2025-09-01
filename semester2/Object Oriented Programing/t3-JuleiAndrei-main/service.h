#pragma once
#include "repository.h"


class Service{

    private:
    Repo &repo;

    public:

    Service(Repo &repo): repo(repo){}

    std::vector <Meal> getMealsService(){
        return repo.getMeals();
    }

    std::vector <Meal> filterListByCaloriesService(int calories){
        return repo.filterList(calories);
    }

    std::vector <Meal> filterListService(std::string mtype,int startHour){
        bool ok=false;
        std::vector <Meal>  wholeList=repo.getMeals();
        for (auto &m:wholeList){
            if (m.getMealType() == mtype && m.getStart() <=startHour && m.getEnd() >= startHour)
                ok=true;
        }
        return repo.mealTypeFilter(mtype,startHour);
        
    }
};