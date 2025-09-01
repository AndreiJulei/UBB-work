import program

def list_by_price(warehouse):
    """
    
    """
    result=[]
    
    result=program.sort_price(warehouse)
    for i in range(len(result)):
        print(program.vec_to_str(result[i]))

def list_by_quantity(warehouse):
    result=[]
    result=program.sort_quantity(warehouse)
    for i in range(len(result)):
        print(program.vec_to_str(result[i]))


def main():
    warehouse=program.initial_warehouse()
    while True:
        command=input()
        command=command.split(" ")
        try:
            if command[0]== "add":
                warehouse=program.add_product(warehouse,command)
            if command[0]=="remove":
                warehouse=program.remove_product(warehouse,command)
            if command[0]=="list" and command[1]=="price":
                list_by_price(warehouse)
            if command[0]=="list" and command[1]=="quantity":
                list_by_quantity(warehouse)
            else:print("Wrong command")
        except ValueError as ve:
            print(ve)
main()

