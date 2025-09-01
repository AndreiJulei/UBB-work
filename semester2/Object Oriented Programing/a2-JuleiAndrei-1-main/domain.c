#include <stdio.h>
#include <string.h>
#include "domain.h"

product create_product(char name[20],char category[20],int quantity,int day,int month,int year)
{
    product p;
    p.quantity=quantity;
    strcpy(p.name,name);
    strcpy(p.category,category);
    p.expiration_date.day=day;
    p.expiration_date.month=month;
    p.expiration_date.year=year;

    return p;
}

void get_category(product p,char category[20]){
    strcpy(category,p.category);
}

void get_name(product p,char name[20]){

    strcpy(name,p.name);
}

int get_quantity(product p){
    return p.quantity;
}

void get_expiration_date(product p, int* day, int* month, int* year) {
    *day = p.expiration_date.day;
    *month = p.expiration_date.month;
    *year = p.expiration_date.year;
}

void set_name(product *p,char name[20])
{
    strcpy(p->name,name);
}

void set_category(product *p,char category[20]){
    strcpy(p->category,category);
}

void set_quantity (product *p,int quantity){
    p->quantity=quantity;
}

void set_date(product* p, int day,int month,int year){
    p->expiration_date.day=day;
    p->expiration_date.month=month;
    p->expiration_date.year=year;
}
