#pragma once
#include "service.h"


typedef struct{
    
    service* serv;
    
}UI;

UI create_UI(service *serv);

void print_menu();

void add_product_UI(service*serv,UI*User_interface);

void remove_product_UI(service*serv,UI*User_interface);

void display_product_UI(service*serv,UI*User_interface);

void update_product_UI(service*serv,UI*User_interface);

void run_UI(UI*User_interface);


