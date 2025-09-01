#
# Functions section
#
import random
from sndhdr import tests


def create_warehouse(name,price,quantity):
    return [name,quantity,price]

def get_name(warehouse):
    return warehouse[0]

def get_price(warehouse):
    return warehouse[2]

def get_quantity(warehouse):
    return warehouse[1]

def set_name(warehouse,name):
    warehouse[0] = name

def set_price(warehouse,price):
    warehouse[2] = price

def set_quantity(warehouse,quantity):
    warehouse[1] = quantity

def vec_to_str(warehouse):
    return f"content: {warehouse[0]}, quantity: {warehouse[1]}, price: {warehouse[2]}"

def initial_warehouse():
    """
    Creates a random set to implement in the warehouse
    :return: the warehouse with random products
    """
    products=["milk","bread","eggs","water"]
    result=[]
    warehouse=[]
    for i in range(0,len(products)):
        quantity=random.randint(1,100)
        price=random.randint(1,100)
        result=create_warehouse(products[i],price,quantity)
        warehouse.append(result)
    return warehouse


def add_product(warehouse,string_input):
    """
    adds a product to the list of products
    :param warehouse: the initial vector
    :param string_input: the command
    :return: the final list with the added products
    """
    if len(string_input)<4 or len(string_input)>=5:
        raise ValueError("wrong command")

    name=string_input[1]
    try:
        quantity=int(string_input[2])
    except: raise ValueError("Wrong Quantity")

    try:
        price=int(string_input[3])
    except: raise ValueError("Wrong Price")
    result=[]
    result=create_warehouse(name,price,quantity)
    warehouse.append(result)
    return warehouse



def remove_product(warehouse,string_input):
    """
    removes a product from the list of products
    :param warehouse: the initial vector
    :param string_input: the input command
    :return: the final list with the removed products
    """
    if len(string_input)<3 or len(string_input)>=4:
        raise ValueError("wrong command")
    result=[]
    try:
        new_price=int(string_input[2])
    except: ValueError("Wrong Price")

    for i in range(len(warehouse)):
        if string_input[1]=="<":
            if get_price(warehouse[i])>new_price:
                result.append(warehouse[i])
        if string_input[1]==">":
            if get_price(warehouse[i])<new_price:
                result.append(warehouse[i])
    return result

def sort_price(warehouse):
    """
    Sorts the list of products by price
    :param warehouse: the initial vector
    :return: the final list with the sorted products
    """
    for i in range(len(warehouse)-1):
        for j in range(i+1,len(warehouse)):
            if get_price(warehouse[i])>get_price(warehouse[j]):
                cpy=warehouse[i]
                warehouse[i]=warehouse[j]
                warehouse[j]=cpy
    return warehouse

def sort_quantity(warehouse):
    """
    Sorts the list of products by quantity
    :param warehouse: the initial vector
    :return: the final list with the sorted products
    """
    for i in range(len(warehouse)-1):
        for j in range(i+1,len(warehouse)):
            if get_quantity(warehouse[i])>get_quantity(warehouse[j]):
                cpy=warehouse[i]
                warehouse[i]=warehouse[j]
                warehouse[j]=cpy
    return warehouse


def list_by_price(warehouse):
    """
    displays the list of products sorted by price
    :param warehouse: the initial vector
    """
    result=[]
    result=sort_price(warehouse)
    for i in range(len(result)):
        print(vec_to_str(result[i]))

def list_by_quantity(warehouse):
    """
    displays the list of products sorted by quantity
    :param warehouse: the initial vector
    """
    result=[]
    result=sort_quantity(warehouse)
    for i in range(len(result)):
        print(vec_to_str(result[i]))


def test_add_product(warehouse):
    name="Beer"
    quantity=100
    price=12
    set_name(warehouse,name)
    set_price(warehouse,price)
    set_quantity(warehouse,quantity)
    add_product(warehouse,"add ciucas 100 10")
    assert [["beer",100,12],["ciucas", 100, 10]]==warehouse

def test_remove(warehouse):
    name = "Beer"
    quantity = 100
    price = 12
    result=[]
    set_name(warehouse, name)
    set_price(warehouse, price)
    set_quantity(warehouse, quantity)
    result.append(warehouse)
    name="timisoreana"
    quantity=90
    price=10
    set_name(warehouse, name)
    set_price(warehouse, price)
    set_quantity(warehouse, quantity)
    result.append(warehouse)
    remove_product(result,"remove > 10")
    assert [["timisoreana",100,90]]==result

    

