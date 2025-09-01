#pragma once

typedef struct
{
    char name[20];
    int quantity;
    char category[20];

    struct {
        int day,month,year;
    }expiration_date;

}product;

product create_product(char name[20],char category[20],int quantity,int day,int month,int year);

void get_category(product p, char category[20]);

void get_name(product p,char name[20]);

int get_quantity(product p);

void get_expiration_date(product p, int* day, int* month, int* year);

void set_name(product* p, char name[20]);

void set_category(product* p, char category[20]);

void set_quantity(product* p, int q);

void set_date(product* p, int day,int month,int year);