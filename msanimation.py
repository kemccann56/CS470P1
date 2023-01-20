import time
from matplotlib.backend_bases import CloseEvent
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import matplotlib as mp
import numpy as np
import random

# merge function for mergesort
def merge (a, left, midpt, right):
    sizeleft = midpt - left + 1
    sizeRight = right - midpt

    vLeft = [None] * sizeleft
    vRight = [None] * sizeRight

    for i in range(sizeleft):
        vLeft[i] = a[left + i]

    for i in range(sizeRight):
        vRight[i] = a[midpt + 1 + i]

    indexLeft = 0
    indexRight = 0
    indexMerged = left
    merged = []

    while indexLeft < sizeleft and indexRight < sizeRight:
        if vLeft[indexLeft] <= vRight[indexRight]:
            merged.append(vLeft[indexLeft])
            indexLeft += 1
        else:
            merged.append(vRight[indexRight])
            indexRight += 1
        indexMerged += 1
    
    while indexLeft < sizeleft:
        merged.append(vLeft[indexLeft])
        indexLeft += 1
        indexMerged += 1

    while indexRight < sizeRight:
        merged.append(vRight[indexRight])
        indexRight += 1
        indexMerged += 1
    
    for i in range(len(merged)):
        a[left + i] = merged[i]
        yield a

# mergesort function
def mergesort (a, left, right):
    if left >= right:
        return
    
    midpt = left + ((right - left + 1) // 2) - 1

    yield from mergesort(a, left, midpt)
    yield from mergesort(a, midpt + 1, right)
    yield from merge(a, left, midpt, right)

# function to close plot
def plotEnd():
    plt.close()

# read in n value
print("Enter n value")
n = input()
a = [None] * int(n)

# read in data
print("Enter data (with n elements)")
for i in range(int(n)):
    x = input()
    a[i] = int(x)

# read in k value
print("Enter k value (k <= n)")
k = input()


fig, ax = plt.subplots()

# 10 second timer to close plot
# https://stackoverflow.com/questions/30364770/how-to-set-timeout-to-pyplot-show-in-matplotlib
timer = fig.canvas.new_timer(interval = 10000)
timer.add_callback(plotEnd)

# bar container 
bars = ax.bar(range(len(a)), a, align = "edge", color = "lightblue")

# find axis limit
max = 0
for i in a:
    if i > max:
        max = i

# set the x and y axis limits, set up graph text and labels
ax.set_xlim(0, len(a))
ax.get_xaxis().set_ticks([])
ax.set_ylim(0, max)
ax.set_title("Mergesort", color = "lightblue")
ax.text(0, 1.01, "k = " + k, transform = ax.transAxes, color = "lightblue")

# animation function
# https://www.geeksforgeeks.org/insertion-sort-visualization-using-matplotlib-in-python/
iterator = [0]  
def animation(A, rects, iterator):
    for rect, val in zip(rects, A):
        # setting the size of each bar equal to the value of the elements
        rect.set_height(val)
        
# call animation function
anim = FuncAnimation(fig, func = animation, fargs = (bars, iterator), frames = mergesort(a, 0, len(a) - 1), interval = 50)
timer.start()
plt.show()

# print top k values
print("\nTop k values:")
for i in range(int(k)):
    print(a[int(n) - 1])
    bars[int(n) - 1].set_color("red")
    n = int(n) - 1

plt.show()