# Solve the problem from the second set here
# Problem number 7

def prime(num:int):
    if num <2:
        return False
    if num%2==0 and num >2:
        return False
    else:
        for i in range (3,num,2):
            if num%i ==0:
                return False
    return True

def pb2():
    n=int(input("write number: "))
    ok=True
    
    while ok:
        if prime(n) and prime(n+2):
            ok= False
            print(f"the numbers that satisfy the conditon are: {n,n+2}")
        n+=1

pb2()