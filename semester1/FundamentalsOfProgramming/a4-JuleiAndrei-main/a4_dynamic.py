# Problem 2:
# Dynamic

def dynamic(vector:list,sum:int):

    matrix=[[False]*(sum+1)for _ in range(len(vector)+1)]     # boolean table

    for i in range(len(vector)+1):
        matrix[i][0]=True                         # base case: sum of 0 can be achieved with an empty set
    

    for i in range (1,len(vector)+1):              # fill the table
        for j in range(1,sum+1):
            if j>=vector[i-1]:
                matrix[i][j]=matrix[i-1][j] or matrix[i-1][j-vector[i-1]]
            else:
                matrix[i][j]=matrix[i-1][j]

    if not matrix[len(vector)][sum]:               #check if the sum can be reached
        return False
    

    result=[]
    i=len(vector)
    j=sum

    while j>0 and i >0:                            #form the final subset
        if matrix[i][j] and not matrix[i-1][j]:
            result.append(vector[i-1])
            j-=vector[i-1]
        i-=1
    
    return result


def main():
    
    print("Write the set of positive integers")
    s_input=input()
    s_list=list(map(int,s_input.split()))
    
    print("Write the number you want to find the sum of")
    k=int(input())
    
    result=dynamic(s_list,k)
    
    if not result:
        print ("Dosent exist")
    else : 
        print (f"The subset that sums up to {k} is:")
        print (result)

main()