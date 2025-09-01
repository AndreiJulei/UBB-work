import math
import random

def create_complex(real, imaginary):
    return [real, imaginary]


def get_real(c):
    return c[0]


def set_real(c, real):
    c[0] = real


def get_imaginary(c):
    return c[1]


def set_imaginary(c, imaginary):
    c[1] = imaginary


def complex_to_str(c):
    return f"{c[0]}+{c[1]}i" if c[1] >= 0 else f"{c[0]}-{-c[1]}i"


'''
def create_complex(real, imaginary):
    return {'real': real, 'imaginary': imaginary}


def get_real(c):
    return c['real']


def set_real(c, real):
    c['real'] = real


def get_imaginary(c):
    return c['imaginary']


def set_imaginary(c, imaginary):
    c['imaginary'] = imaginary


def complex_to_str(c):
    return f"{c['real']}+{c['imaginary']}i" if c['imaginary'] >= 0 else f"{c['real']}-{-c['imaginary']}i"
'''


def calc_module(integer_part, imaginary_part):
    """
    Generate the module of a complex number
    :param integer_part: the integer part of a complex number
    :param imaginary_part: the imaginary part of a comlpex number
    """
    return int(math.sqrt(integer_part ** 2 + imaginary_part ** 2))


def list_to_complex_list(vector)->list:
    
    """
    Turns a list of real numbers into a complex one using strings
    :param vector: list of real numbers
    """
    
    return [complex_to_str([vector[i], vector[i + 1]]) for i in range(0, len(vector), 2)]


def longest_sub_of_module(numbers):

    """
    Find the longest subarray of numbers with strictly increasing modulus.
    :param numbers: list of complex numbers
    """
    
    if not numbers:
        raise ValueError("Array is empty")

    last_module = -1
    current_subsequence = []
    longest_subsequence = []
    
    for i in range(0, len(numbers) ):
        real = get_real(numbers[i])
        imaginary=get_imaginary(numbers[i])
        current_module = calc_module(real, imaginary)

        if current_module >= last_module:
            current_subsequence.append([real, imaginary])
        else:
            if len(current_subsequence) > len(longest_subsequence):
                longest_subsequence = current_subsequence
            
            current_subsequence = [[real, imaginary]]

        last_module = current_module

    if len(current_subsequence) > len(longest_subsequence):
        longest_subsequence = current_subsequence

    for i in range(0,len(longest_subsequence)):
        longest_subsequence[i]=complex_to_str(longest_subsequence[i])

    print("Longest subsequence with increasing modulus:", longest_subsequence)
    return longest_subsequence


def complex_to_module_list (numbers):
    """
    Creates a list of the modules from the complex numbers  
    :param numbers: list of complex numbers
    """
    module_list=[]
    for i in numbers:
        real_part=get_real(i)
        imag_part=get_imaginary(i)
        module=calc_module(real_part,imag_part)
        module_list.append(module)
    return module_list



def longest_sub_alternating(numbers):
   
    """
    Finds the longest subsequence with alternating modulus
    :param numbers: list of complex numbers 
    """

    module_list=complex_to_module_list(numbers)
    n=len(module_list)
    up = [1] * n
    down = [1] * n
    prev_up = [-1] * n  
    prev_down = [-1] * n 

    for i in range(1, n):
        for j in range(i):
            if module_list[i] > module_list[j]:  
                if down[j] + 1 > up[i]:
                    up[i] = down[j] + 1
                    prev_up[i] = j
            elif module_list[i] < module_list[j]:  
                if up[j] + 1 > down[i]:
                    down[i] = up[j] + 1
                    prev_down[i] = j

    max_length = 0
    max_end_index = -1
    last_type = 'up' 
    
    for i in range(n):
        if up[i] > max_length:
            max_length = up[i]
            max_end_index = i
            last_type = 'up'
        if down[i] > max_length:
            max_length = down[i]
            max_end_index = i
            last_type = 'down'

    subsequence = []
    while max_end_index != -1:
        subsequence.append(module_list[max_end_index])
        if last_type == 'up':
            max_end_index = prev_up[max_end_index]
            last_type = 'down'
        else:
            max_end_index = prev_down[max_end_index]
            last_type = 'up'

    subsequence.reverse()
    print("the longest subsequence is:")
    print(subsequence)
    return subsequence
        


def add_number(numbers, real, imaginary):
    """
    Adds a complex number to the existing list and returns it 
    :param numbers: previous list of complex numbers
    :param real: the real part of a number 
    :param imaginary: the imaginary part of o number
    """

    number = create_complex(real, imaginary)
    numbers.append(number)
    return numbers


def create_new_list(numbers):

    """
    Adds a new list introduced from the console to the existing list of complex numbers
    :param numbers: list of complex numbers
    """
    
    v = input("List of complex numbers separated by a comma (ex:5+4i,3i,2+i): ")
    v = v.split(",")
    for number in v:
        number = number.replace("i", "j") 
        complex_number = complex(number) 
        real = int(complex_number.real)
        imaginary = int(complex_number.imag)
        add_number(numbers, real, imaginary)
    return numbers


def display_list(numbers):
    for i in numbers:
        print(complex_to_str(i))


def op1(numbers):
    return create_new_list(numbers)


def op2(numbers):
    display_list(numbers)


def op3(numbers):
    longest_sub_of_module(numbers)  


def op4(numbers):
    longest_sub_alternating(numbers)


def gen_numb(length:int):

    """
    Creates a list of complex numbers
    :param length: length of the list we want to generate
    """

    result=[]
    for i in range(length):
        part_real=random.randint(0,50)
        part_imag=random.randint(0,50)
        complex_numb=create_complex(part_real,part_imag)
        result.append(complex_numb)
    
    return result


def menu_print():
    print("1. Add to the list of complex numbers")
    print("2. Display all complex numbers")
    print("3. Display longest subarray of numbers having increasing modulus")
    print("4. Display longest alternating subsequence, when considering the modulus of each number")
    print("0. Exit")


def main():
    numbers = gen_numb(10)
    while True:
        menu_print()
        command = input(">")
        try:
            if command == '1':
                numbers = op1(numbers)
            elif command == '2':
                op2(numbers)
            elif command == '3':
                op3(numbers)
            elif command == '4':
                op4(numbers)
            elif command == '0':
                break
            else:
                raise ValueError("Wrong input")
        except (ValueError, TypeError) as error:
            print(error)

main()
