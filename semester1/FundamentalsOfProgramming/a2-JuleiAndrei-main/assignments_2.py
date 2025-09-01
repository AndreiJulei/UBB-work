import random

def is_sorted(a: list) -> bool:
    for i in range(0,len(a) - 1):  
        if a[i] > a[i + 1]:
            return False
    return True

def gen_p(a, step, result, ind,jump):
    if ind == len(a) - 1:
        if is_sorted(a):
            for i in range(len(a)):
                result.append(a[i])
        jump +=1
        if jump%step==0:
            print (a)
        return

    for i in range(ind, len(a)):  
        a[ind], a[i] = a[i], a[ind]  
        gen_p(a, step, result, ind + 1,jump+1)  
        a[ind], a[i] = a[i], a[ind]  

def p_sort(a, step):
    result = []
    gen_p(a, step, result, 0,0)  
    print("the sorted list: ")
    print(result)
    return result

# Command 1:
def create_list(x: int) -> list:
    return [random.randint(1, 1000) for _ in range(x)]  

# Command 4:
def binsearch(a, st, dr, x):
    while st <= dr:
        mij = (st + dr) // 2
        if a[mij] == x:
            return mij
        elif a[mij] < x:
            st = mij + 1
        else:
            dr = mij - 1
    return -1

def exponential_search(a, x):
    if a[0] == x:
        return 0
    i = 1
    while i < len(a) and a[i] <= x:
        i *= 2
    
    return binsearch(a, i // 2, min(i, len(a) - 1), x)

# Command 3:
def strand(a: list):
    if not a:
        return []
    
    sublist = []
    sublist.append(a.pop(0))
    element = 0
    
    while element < len(a):
        if sublist[-1] <= a[element]:  
            sublist.append(a.pop(element))
        else:
            element += 1 
    
    return sublist

def merge(a, b):
    result = []
    while len(a) > 0 and len(b) > 0:  
        if a[0] <= b[0]:
            result.append(a.pop(0))
        else:
            result.append(b.pop(0))
    result += a + b  
    return result

def strand_sort(a: list, step: int):
    output = []
    cnt = 0
    while len(a):
        cnt += 1
        output = merge(output, strand(a))
        if cnt % step == 0:
            print(a, output)

    print("The sorted list: ")
    print(output)
    return output

def main():
    a = []
    while True:
        print ("''''''''''''''''''''''''''''''''''''''''''''''''''''''''")
        print("1. Create list of numbers")
        print("2. Sort using Permutation Sorting")
        print("3. Sort using Strand Sorting")
        print("4. Search using Exponential Search")
        print("5. Show the list")
        print("0. Quit")
        print ("''''''''''''''''''''''''''''''''''''''''''''''''''''''''")
        command = input("> ")

        if command == '1':
            x = int(input("Number of elements: "))
            a = create_list(x)
            print(a)
        elif command == '5':
            if not a:
                print("Please generate the list of numbers first.")
            else:
                print(a)
        elif command == '2':
            if not a:
                print("Please generate the list of numbers first.")
            else:
                step = int(input("Please insert the step: "))
                a = p_sort(a, step)

        elif command == '3':
            if not a:
                print("Please generate the list of numbers first.")
            else:
                step = int(input("Please insert the step: "))
                a = strand_sort(a, step)
        elif command == '4':
            if not a:
                print("Please generate the list of numbers first.")
            elif not is_sorted(a):
                print("Please sort the list using one of the two methods available.")
            else:
                x = int(input("Write the number you want to search in the list: "))
                index = exponential_search(a, x)
                
                if index >= 0:
                    print(f"The number was found at position {index}.")
                else:
                    print("The number was not found.")
        elif command == '0':
            break
        else:
            print("Bad command or file name.")

main()
