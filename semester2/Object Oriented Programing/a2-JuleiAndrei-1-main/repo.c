#include <string.h>
#include <stdio.h>
#include "repo.h"

repo create_repo(){
    repo repository;
    repository.lenght=0;
    return repository;
}

int get_length(repo repository){
    return repository.lenght;
}
void add_product(repo* repository, product p) {
    for (int i = 0; i < repository->lenght; i++) {
        if (strcmp(repository->products[i].name, p.name) == 0 &&
            strcmp(repository->products[i].category, p.category) == 0) {
            repository->products[i].quantity += p.quantity;
            return;
        }
    }
    repository->products[repository->lenght++] = p;
}

void remove_product(repo *repository,product p){
    int len=repository->lenght;
    int poz=-1;
    for (int i=0;i<len;i++){
        if(repository->products[i].name == p.name && repository->products[i].category == p.category)
            poz=i;
    }
    for (int i=poz;i<len;i++)
        repository->products[i]=repository->products[i+1];
    repository->lenght--;
    
}