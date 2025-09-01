#pragma onceclear
#include <iostream>
#include <string>
#include <vector>

class Meal{

    private:
    int start,end;
    std::string mealType;
    int calorieCount;
    std :: string description;


    public:

    Meal(int start,int end, std :: string mealType, int calorieCount, std::string description): start(start),end(end),mealType(mealType), calorieCount(calorieCount),description(description){}
    
    int getStart()const
    {
        return start;
    }
     int getEnd()const
    {
        return end;
    }

     int getCalories()const
    {
        return calorieCount;
    }

    std :: string getMealType()const{
        return mealType;
    }

    std :: string getDescription()const{
        return description;
    }

    std :: string toString()const{
        return std:: to_string(start) +";"+ std :: to_string(end) +";" + mealType + ";" + std :: to_string(calorieCount) +";"+ description;
    }
};