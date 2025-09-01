#include "domain.h"

class Portofolio{

    private:
    std :: vector <Instrument*> instruments;

    public:

    void addInstrument(Instrument* instrument){
        instruments.push_back(instrument);
    }

    std :: vector <Instrument*> getAllInstruments(){    
        return instruments;
    }

    std :: vector <Instrument*> profitableInstruments(){
        std :: vector <Instrument*> profitable;
        
        for (Instrument* instrument : instruments){
            if (instrument->computeProfit()>0){
                profitable.push_back(instrument);
            }
        }
        return profitable;
    }

    void writeToFile(std::string filename){
        std ::ofstream out(filename);
        for (Instrument* instrument : instruments){
            out << instrument->toString();
        }
    }

};