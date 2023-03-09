#  File: work.py

#  Description: Using binary and linear search with series sum to figure out the minimum allowable value of v for a given productivity factor that will allow him to write at least n lines of code before he falls asleep.



import sys
import time


# Input: v an integer representing the minimum lines of code and
#        k an integer representing the productivity factor
# Output: computes the sum of the series (v + v // k + v // k**2 + ...)
#         returns the sum of the series
def sum_series (v, k):
    tot = 0
    x = 0
    while True:
        lineofcode = v//k**x
        tot += lineofcode
        if lineofcode == 0:
            break
        x += 1
    return tot 




# Input: n an integer representing the total number of lines of code
#        k an integer representing the productivity factor
# Output: returns v the minimum lines of code to write using linear search
def linear_search(n, k):
  v = 1
  # Continue until sum of series is greater than or equal to n
  while sum_series(v, k) < n:
    v = v + 1
  return v


# Input: n an integer representing the total number of lines of code
#        k an integer representing the productivity factor
# Output: returns v the minimum lines of code to write using binary search
def binary_search (n, k):
  # Set lower bound to 1 and upper bound to n
  lo = 1
  hi = n
  # Repeat until lower bound is less than or equal to upper bound
  while lo <= hi:
    # middle value
    mid = (lo + hi) // 2
    # sum of series for middle value
    s = sum_series(mid, k)
    #sum is less than n, set lower bound to mid + 1
    if s < n:
      lo = mid + 1
    #sum is greater than n, set upper bound to mid - 1
    elif s > n:
      hi = mid - 1
    #sum is equal to n, return middle value
    else:
      return mid
  # minimum value
  return lo




def main():
  # read number of cases
  line = sys.stdin.readline()
  line = line.strip()
  num_cases = int (line)

  for i in range (num_cases):
    line = sys.stdin.readline()
    line = line.strip()
    inp =  line.split()
    n = int(inp[0])
    k = int(inp[1])

    start = time.time()
    print("Binary Search: " + str(binary_search(n, k)))
    finish = time.time()
    print("Time: " + str(finish - start))

    print()

    start = time.time()
    print("Linear Search: " + str(linear_search(n, k)))
    finish = time.time()
    print("Time: " + str(finish - start))

    print()
    print()

if __name__ == "__main__":
  main()
