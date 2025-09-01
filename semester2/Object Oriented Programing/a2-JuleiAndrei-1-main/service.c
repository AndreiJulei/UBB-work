#include "service.h"
#include <stdio.h>


service create_service(repo *repository){

    service serv;
    serv.repository = repository;
    return serv;
}

void add_product_service(service *serv,product p){
    add_product(serv->repository,p);
}


void remove_product_service(service *serv,product p){
    
    remove_product(serv->repository,p);
}


void display_product_service(service *serv,product p){

}