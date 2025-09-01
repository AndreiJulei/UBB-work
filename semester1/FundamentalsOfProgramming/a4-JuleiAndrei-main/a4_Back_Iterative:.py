# Problem 1
# Iterative:

def it(num,vec,sum):
    result = []
    
    stack = [(0, 0, [])] 
    
    while stack:
        current_sum, start_index, current_combination = stack.pop()
        print(stack)
        if current_sum == sum:
            result.append(current_combination)
        
        for i in range(start_index, len(vec)):
            new_sum = current_sum + vec[i]

            if new_sum <= sum:
                stack.append((new_sum, i+1, current_combination + [vec[i]]))

    if not result:
        print("No payment modality exists.")
    else:
        print("Payment modalities for the sum", sum, ":")
        for modality in result:
            print(modality)

def mn():

    n=int(input("Write the number of coins: "))
    
    input_str=input("Enter the value of the coins: ")
    c = list(map(int, input_str.split()))
    
    s=int(input("Write the sum you want to pay: "))
    ok = False
    it(n,c,s)

mn()
