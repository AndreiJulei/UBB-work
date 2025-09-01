#include <stdio.h>
#include "domain.h"
#include "service.h"
#include "repo.h"
#include "ui.h"

/*
The company _“Home SmartApps”_ have decided to design a new intelligent refrigerator. Besides the hardware, 
they need a software application to manage the refrigerator. Each **Product** that the fridge can store has a `name`, a
 `category` (one of `dairy, sweets, meat or fruit`), a `quantity` and an `expiration date`. The software application will 
provide the following functionalities:  
**(a)** Add, delete or update a product. A product is uniquely identified by name and category. 
If a product that already exists is added, its quantity will be updated (the new quantity is added to the existing one).  
**(b)** Display all products whose name contains a given string (if the string is empty, all products from the 
refrigerator are considered), and show them sorted ascending by the existing quantity.  
*/




int main(){

    repo repository;
    repository.lenght=0;

    service serv={&repository};
    UI ui={&serv};

    run_UI(&ui);
    
    return 1;
}