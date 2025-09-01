#pragma once
#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <vector>
#include <string>

class Instrument{

    protected:
    std :: string name;
    double buyPrice;
    double sellPrice;

    public:
    
    Instrument(std::string name, double buyPrice, double sellPrice): name(name), buyPrice(buyPrice),sellPrice(sellPrice){}

    virtual double computeProfit()=0;

    virtual std::string toString()=0;
};


class Stock: public Instrument{

    protected:
    double shares;

    public:

    Stock(std::string &name, double &buyPrice, double &sellPrice, double shares): Instrument(name,buyPrice,sellPrice),shares(shares){}

    virtual double computeProfit() override{
        return (sellPrice-buyPrice) * shares;
    }

    virtual std::string toString() override{
        return "Name: "+ name +", Type: Stock, buy price: " + std::to_string(buyPrice) + ", sell price: " + std :: to_string(sellPrice)+ ", shares: " + std::to_string(shares) + "\n";
    }

};


class Option:public Instrument{


    protected:
    double strikePrice;
    std::string optionType;

    public:
    Option(std::string &name, double &buyPrice, double &sellPrice, double strikePrice,std :: string optionType): Instrument(name,buyPrice,sellPrice),strikePrice(strikePrice),optionType(optionType){}

    virtual double computeProfit() override{
        if (optionType=="CALL"){
            return sellPrice-strikePrice;
        } else if(optionType == "PUT"){
            return strikePrice-buyPrice;
        } else return -1;
    }


    virtual std::string toString() override{
        return "Name: "+ name +", Type: Option, buy price: " +std::to_string(buyPrice) + ", sell price: " +std :: to_string(sellPrice)+ ", Type of option: " + optionType + ", strike price: " +std :: to_string(strikePrice) +"\n";
    }


};