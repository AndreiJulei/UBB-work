import random
import timeit


# Command 2 - permutation sort:
def is_sorted(a: list) -> bool:
    for i in range(0,len(a) - 1):  
        if a[i] > a[i + 1]:
            return False
    return True

def gen_p(a, step, result, ind,jump,ok):
    if ind == len(a) - 1:
        if is_sorted(a):
            ok=True
            for i in range(len(a)):
                result.append(a[i])

        #if jump%step==0:
         #   print (a)
        return

    for i in range(ind, len(a)):  
        cpy=a[ind]
        a[ind] = a[i]
        a[i]=cpy  
        gen_p(a, step, result, ind + 1,jump,ok) 
        if ok==True:
            break 
        jump+=1
        cpy=a[ind]
        a[ind] = a[i]
        a[i]=cpy 

def p_sort(a, step):
    result = []
    is_sorted=False
    gen_p(a, step, result, 0,0,False)  
    #print("the sorted list: ")
    #print(result)
    return result

# Command 1 - Generating the list:
def create_list(x: int) -> list:
    return [random.randint(1, 1000) for _ in range(x)]  

# Command 4 - Exponential search:
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

# Command 3 - Strand sort:
def strand(a: list):
    
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
        #if cnt % step == 0:
          #  print(a, output)

    #print("The sorted list: ")
    #print(output)
    return output

def gen_lists(unsorted:list)->list:
    list500=[]
    list500=create_list(500)

    list1000=[]
    list1000=create_list(1000)

    list4000=[]
    list4000=create_list(4000)

    list8000=[]
    list8000=create_list(8000)

    unsorted.append(list500)
    unsorted.append(list1000)
    unsorted.append(list4000)
    unsorted.append(list8000)

    return unsorted

def gen_small(p_unsorted):
    list10=[]
    list10=create_list(10)
    list25=[]
    list25=create_list(25)
    list50=[]
    list50=create_list(50)
    list100=[]
    list100=create_list(100)

    p_unsorted.append(list10)
    p_unsorted.append(list25)
    p_unsorted.append(list50)
    p_unsorted.append(list100)
    
    return p_unsorted

def time_alg_strand(sorted):
    start=timeit.default_timer()
    strand_sort(sorted,1)
    end=timeit.default_timer()  

    return end-start


def time_alg_perm(sorted):
    start=timeit.default_timer()
    p_sort(sorted,1)
    end=timeit.default_timer()
    
    return end-start


def accending_l(a,x):
    sortat= []
    for i in range(1,x+1):
        sortat.append(i)
    return sortat


def deccending_l(a,x):
    descrescator=[]
    for i in range(x+1,1,-1):
        descrescator.append(i)
    return descrescator

def main():
    a = []
    while True:
        print ("'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''")
        print("1. Create list of numbers")
        print("2. Sort using Permutation Sorting")
        print("3. Sort using Strand Sorting")
        print("4. Search using Exponential Search")
        print("5. Show the list")
        print("6. Show the best case for strand sort and permutasion sort")
        print("7. Show the average case for strand sort and permutation sort")
        print("8. Show the worst case for strand sort and permutation sort")
        print("0. Quit")
        print ("'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''")
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

        elif command >'5' and command <='8':
            unsorted=[]
            gen_lists(unsorted)
            A_list=[500,1000,4000,8000]

            p_unsorted=[]
            p_unsorted=gen_small(p_unsorted)
            B_list=[7,8,9,10]

            if command == '6':  
                sortat=[]
                print("The best case for strand sort and permutasion sort is: ")
                for i in range(len(unsorted)):
                    sortat=accending_l(sortat,A_list[i])
                    print(f"{A_list[i]} / {B_list[i]}, {time_alg_strand(sortat),time_alg_perm(p_unsorted[i])}")

            elif command == '7':
                print("The average case for strand sort and permutations sort is:")
                for i in range(len(unsorted)):
                    print(f"{len(unsorted[i])} / {B_list[i]}, {time_alg_strand(unsorted[i]),time_alg_perm(p_unsorted[i])}")

            elif command =='8':
                sortat_d=[]
                print("The worst case for strand sort and permutation sort is:")

                for i in range(len(unsorted)):
                    sortat_d=deccending_l(sortat_d,A_list[i])
                    print(f"{A_list[i]} / {B_list[i]}, {time_alg_strand(sortat_d),time_alg_perm(p_unsorted[i])}")

        elif command == '0':
            break
        else:
            print("Bad command or file name.")

main()
