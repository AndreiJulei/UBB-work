# Solve the problem from the first set here
# problem number 2:

def prime(num)-> bool:
    
    if num <2:
        return False
    if num%2==0 and num >2:
        return False
    else:
        for i in range (3,num,2):
            if num%i ==0:
                return False
    return True


def function_pr2()-> None:
    
    n=int(input("Write number: "))
    ok= False
    for p1 in range(2,n):
        p1=int(p1)
        if prime(p1):
            if prime(n-p1) :
                print (f"the numbers that satisfy the condition are: {p1,n-p1}")
                ok= True
                break
            
    if not ok:
        print("numbers not found")
        
function_pr2()