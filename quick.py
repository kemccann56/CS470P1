def partition(a, left, right):
    x = a[right]
    i = left

    for j in range(left, right):
        if a[j] >= x:
            a[i], a[j] = a[j], a[i]
            i += 1

    a[i], a[right] = a[right], a[i]
    return i

def findK(arr, left, right, k):
    index = partition(arr, left, right)

    if (index - left == k - 1):
        return arr[index]
  
    if (index - left > k - 1):
        return findK(arr, left, index - 1, k)
  
    return findK(arr, index + 1, right, k - index + left - 1)

# read in n value
print("Enter n value")
n = input()
arr = [None] * int(n)

# read in data
print("Enter data (with n elements)")
for i in range(int(n)):
    x = input()
    arr[i] = int(x)

# read in k value
print("Enter k value (k <= n)")
k = input()

# gets and prints lowest k elements
print("\n")
for q in range(int(k)):
    print(findK(arr, 0, int(n) - 1, q + 1))