# create an array using X and Y (2 int arrays) such that element of X[i] is placed in the new array at postion Y[i]
# e.g.
# X = [1, 2, 3, 4, 5]
# Y = [0, 1, 2, 2, 2]
#
# i	    X[i]	Y[i]	arr
# 1	    1	    0	    [1]
# 2	    2	    1	    [1, 2]
# 3	    3	    2	    [1, 2, 3]
# 4	    4	    2	    [1, 2, 4, 3]
# 5	    5	    2	    [1, 2, 5, 4, 3]
#  1<= x[i] , y[i] <=100

def wosh_wosh_woshah(x = [] , y = []):
    # arr = [0] * len(x)
    arr = []
    for i in range(0,len(x)):
        if y[i] > len(arr) - 1 :
            arr.append(x[i])
        else:
            left = arr[0:y[i]]
            right = arr[y[i]:]
            arr = left + [x[i]] + right
            print(left, right)
        print(arr, x[i], y[i])
    return arr

wosh_wosh_woshah([1, 2, 3, 4, 5],[0, 1, 2, 2, 2])