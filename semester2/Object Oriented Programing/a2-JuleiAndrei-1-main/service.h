#pragma once
#include "repo.h"

typedef struct
{
    repo* repository;

}service;


service create_service(repo *repository);

void add_product_service(service *serv,product p);

void remove_product_service(service *serv,product p);

