# Solve the problem from the third set here
# Problem number 13


def prime(num:int)->bool:
    if num <2:
        return False
    if num%2==0 and num >2:
        return False
    else:
        for i in range (3,num,2):
            if num%i ==0:
                return False
    return True

def pb3():
    n=int(input("write number: "))
    cnt= int(1)
    i= int(2)
    fn=int (1)
    while cnt <= n:
        if prime (i):
            fn = i
            cnt+=1
        else:
            d=int(2)
            ci=i
            while ci>1 and cnt<=n:
                p=0
                while ci%d==0:
                    ci/=d
                    ci= int(ci)
                    p=1
                if p:
                    cnt+=1
                    fn=d
                
                d+=1
                if d*d>ci:
                    d=ci
        i +=1
    print (f"The {n}'th element in the sequence is: {fn}")

pb3()