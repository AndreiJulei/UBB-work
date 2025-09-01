#pragma once
#include "domain.h"

typedef struct {
    product products[100];
    int lenght;
}repo;

repo create_repo();

int get_length(repo repository);

void add_product(repo *repository,product p);

void remove_product(repo *repository,product p);

