#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "ui.h"


UI create_UI(service* serv) {
    UI User_interface;
    User_interface.serv = serv;
    return User_interface;
}


void print_menu() {
    printf("1. Add a product\n");
    printf("2. Remove a product\n");
    printf("3. Display product that contains a given string\n");
    printf("4. Update a product\n");
    printf("5. Exit\n");
}


void add_product_UI(service *serv, UI *User_interface) {
    char name[20], category[20];

    printf("Write name: ");
    scanf("%s", name);  // Proper input handling
    getchar();

    printf("Write category: ");
    scanf("%s", category);
    getchar();

    int quantity, day, month, year;
    printf("Write quantity: ");
    scanf("%d", &quantity);
    getchar();

    printf("Write expiration date (day.month.year): ");
    scanf("%d.%d.%d", &day, &month, &year);
    getchar();

    product p = create_product(name, category, quantity, day, month, year);
    add_product_service(User_interface->serv, p);
}


void remove_product_UI(service *serv, UI *User_interface) {
    printf("Enter the name and category of the product you want to remove\n");

    char name[20], category[20];
    printf("Write name: ");
    scanf("%s", name);
    getchar();

    printf("Write category: ");
    scanf("%s", category);
    getchar();

    product p = create_product(name, category, 0, 0, 0, 0);
    repo *memory_repo = User_interface->serv->repository;

    int poz = -1;
    for (int i = 0; i < memory_repo->lenght; i++) {
        if (strcmp(memory_repo->products[i].name, p.name) == 0 && strcmp(memory_repo->products[i].category, p.category) == 0) {
            poz = i;
            break;
        }
    }

    if (poz == -1) {
        printf("There is no product with the given name and category\n");
    } else {
        remove_product_service(User_interface->serv, p);
    }
}


void display_product_UI(service *serv, UI *User_interface) {
    printf("Choose the name of the product you want to display, or a string: ");
    char name[20];
    scanf("%s", name);
    repo *memory_repo = User_interface->serv->repository;


    product matching_products[memory_repo->lenght];
    int matching_count = 0;


    if (strcmp(name, "all") == 0) {
        for (int i = 0; i < memory_repo->lenght; i++) {
            matching_products[matching_count++] = memory_repo->products[i];
        }
    } else {
        for (int i = 0; i < memory_repo->lenght; i++) {
            if (strstr(memory_repo->products[i].name, name) != NULL) {
                matching_products[matching_count++] = memory_repo->products[i];
            }
        }
    }
    if (matching_count == 0) {
        printf("There are no products that match the given string.\n");
    } else {
        for(int i=0; i<matching_count-1; i++)
          for(int j=i; j<memory_repo->lenght; j++) {
           if (matching_products[i].quantity > matching_products[j].quantity) {
             product aux = matching_products[j];
             matching_products[j] = matching_products[i];
             matching_products[i] = aux;
           }
          }

        for (int i = 0; i < matching_count; i++) {
            printf("%s, %s, %d, %d/%d/%d\n",
                   matching_products[i].name,
                   matching_products[i].category,
                   matching_products[i].quantity,
                   matching_products[i].expiration_date.day,
                   matching_products[i].expiration_date.month,
                   matching_products[i].expiration_date.year);
        }
    }
}


void update_product_UI(service *serv, UI *User_interface) {

      printf("Choose the name of the product you want to update: ");
      char name[20];
      scanf("%s", name);
      getchar();
      printf("Choose the category of the product you want to update: ");
      char category[20];
      scanf("%s", category);
      getchar();
      printf("Choose the new quantity of the product to update: ");
      int new_quantity;
      scanf("%d", &new_quantity);

      repo *memory_repo = User_interface->serv->repository;
      bool ok = false;
      for (int i = 0; i < memory_repo->lenght; i++) {
        if (strcmp(memory_repo->products[i].name, name) == 0 && strcmp(memory_repo->products[i].category, category) == 0) {
          memory_repo->products[i].quantity=new_quantity;
          ok=true;
          break;
        }
      }
       if (!ok)
         printf("There is no product with the given name and category\n");

}


void run_UI(UI *User_interface) {
    int option = 0;
    while (option != 5) {  // Change to option 5 to exit properly
        print_menu();
        printf("Choose an option (1->5): ");
        scanf("%d", &option);
        getchar();  // Flush newline character

        if (option == 1) {
            add_product_UI(User_interface->serv, User_interface);
        } else if (option == 2) {
            remove_product_UI(User_interface->serv, User_interface);
        } else if (option == 3) {
            display_product_UI(User_interface->serv, User_interface);
        } else if (option == 4) {
            update_product_UI(User_interface->serv, User_interface);
        } else if (option == 5) {
            printf("Exiting\n");
            break;
        } else {
            printf("Wrong option\n");
        }
    }
}
