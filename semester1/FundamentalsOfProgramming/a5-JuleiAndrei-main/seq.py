"""
def longest_alt_seq(numbers):
    dec=1
    inc=1
    n=len(numbers)

    for i in range (1,n):
        if numbers[i]>numbers[i-1]:
            inc=dec+1
        elif numbers[i]<numbers[i-1]:
            dec=inc+1
        
    return max(inc,dec)
"""

def longest_alternating_subsequence(arr):
    # Edge case: if the array has 0 or 1 elements, return its length
    if not arr:
        return 0
    if len(arr) == 1:
        return 1
    
    # Get the absolute values of the array for modulus comparison
    n = len(arr)
    abs_arr = [abs(x) for x in arr]
    
    # DP arrays to store the length of subsequence ending at index i
    dp_up = [1] * n  # dp_up[i]: Length of subsequence where arr[i] > arr[i-1]
    dp_down = [1] * n  # dp_down[i]: Length of subsequence where arr[i] < arr[i-1]
    
    # Build the DP table
    for i in range(1, n):
        for j in range(i):
            if abs_arr[i] > abs_arr[j]:
                dp_up[i] = max(dp_up[i], dp_down[j] + 1)
            elif abs_arr[i] < abs_arr[j]:
                dp_down[i] = max(dp_down[i], dp_up[j] + 1)

    # The result is the maximum length of the alternating subsequences
    return max(max(dp_up), max(dp_down))

# Test the function
arr = [1, 3, 2, 4, 10, 6, 1]
print(longest_alternating_subsequence(arr))  # Output: 5 (subsequence: [1, 3, 2, 10, 1])

"""
numbers=[1,2,1,2,1,1]
print(longest_alt_seq(numbers))
"""