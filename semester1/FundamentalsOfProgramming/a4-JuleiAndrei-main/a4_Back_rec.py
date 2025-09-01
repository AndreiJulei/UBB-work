# Problem 1
# RECURSIVE:


def back(num,vec,sum,res):
    if num<0:
        if sum ==0:
            result=[]
            for i in range(len(vec)):
                if vec[i]!=0:
                    result.append(vec[i])
            res.append(result)
        return 

    if sum - vec[num] >= 0:
        nr=vec[num]
        back ( num-1, vec, sum-nr, res )
    
    cpy=vec[num]
    vec[num]=0
    back ( num-1, vec, sum, res )
    vec[num]=cpy


def mn():
    n=int(input("Write the number of coins: "))
    
    input_str=input("Enter the value of the coins: ")
    c = list(map(int, input_str.split()))
    
    s=int(input("Write the sum you want to pay: "))
    
    result=[]
    back(n-1,c,s, result)
    
    if result:
        for i in range(len(result)):
            print(result[i])
    else :
        print ("there are no possible ways to pay the sum")

mn()