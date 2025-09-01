# Problem 2
# Naive:

def back(num,vec,sum,res):
    if num<0:
        if sum ==0 and not res:
            
            for i in range(len(vec)):
                if vec[i]!=0:
                    res.append(vec[i])
            print (res)

    elif not res:
        if sum-vec[num]>=0:
            nr=vec[num]
            back ( num-1, vec, sum-nr, res )
        
        cpy=vec[num]
        vec[num]=0
        back ( num-1, vec, sum, res )
        vec[num]=cpy


def mn():
    print("Write the set of positive integers: ")
    input_str=input()
    c = list(map(int, input_str.split()))
    print("Write the number you want to represent: ")
    k=int(input( ))
    ok= False
    result=[]
    back(len(c)-1, c, k, result)
    
mn()

