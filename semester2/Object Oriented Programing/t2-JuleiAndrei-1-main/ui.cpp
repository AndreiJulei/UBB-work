#include "ui.h"


void UI::runUi(){
    int choise;
    while (true)
    {
        
        std :: cout << "1.Add instrument \n2.Show all instruments \n3.Show all profitable instruments \n4.Save to file \n5.Exit \n";

        std :: cout << "Choose an option: ";
        std :: cin >> choise;

        if (choise == 1){
            int cc;
            std :: cout <<"1.Stock \n2.Option \n";
            std :: cout <<"Choose witch instrument to add(1 / 2): ";
            std :: cin >> cc;

            if (cc == 1){
                std :: string name;
                double buyPrice;
                double sellPrice;
                double shares;
                
                std :: cout << "Write name: ";
                std :: cin >> name;
                
                std :: cout << "Write buy price: ";
                std :: cin >> buyPrice;

                std :: cout << "Write sell price: ";
                std :: cin >> sellPrice;


                std :: cout << "Write share: ";
                std :: cin >> shares;

                portofolio->addInstrument(new Stock(name,buyPrice,sellPrice,shares));

            } else if(cc == 2){
                std :: string name;
                double buyPrice;
                double sellPrice;
                double strikeprice;
                std :: string optionType;
                
                std :: cout << "Write name: ";
                std :: cin >> name;
                
                std :: cout << "Write buy price: ";
                std :: cin >> buyPrice;

                std :: cout << "Write sell price: ";
                std :: cin >> sellPrice;

                
                std :: cout << "Write sell strike price: ";
                std :: cin >> strikeprice;
                std :: cout << "Write sell option type (CALL/PUT): ";
                std :: cin >> optionType;
                portofolio->addInstrument(new Option(name,buyPrice,sellPrice,strikeprice,optionType));
            } else {
                std :: cout << "Wrong option\n";
            }

        } else if (choise == 2){
            std :: vector <Instrument*> instruments;
            instruments = portofolio->getAllInstruments();
            for (Instrument * instrument : instruments){
                std :: cout << instrument->toString();
            }
        } else if(choise == 3){

            std :: vector <Instrument*> instruments;
            instruments = portofolio->profitableInstruments();
            for (Instrument * instrument : instruments){
                std :: cout << instrument->toString();
            }

        } else if(choise == 4){
            std :: string filename;
            std :: cout << "Write the name of the file you want to save to: ";
            std :: cin >> filename;

            portofolio->writeToFile(filename);
        
        } else if(choise == 5){
            break;
        } else {
            std :: cout << "Wrong option!\n";
        }
    }
    
}