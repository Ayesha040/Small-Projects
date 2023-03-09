#  File: Interval.py

#  Description: A basic interval class.


import sys

class IntegerInterval (object):
    # constructor with default values
    def __init__(self, beginning = 0, end = 0):
        self.beginning = beginning
        self.end = end


    # creates a string representation of an Interval
    # returns a string in the form "Beginning: startTime, End: endTime"
    def __str__(self):
        return ('Beginning: {}, End: {}'.format(self.beginning, self.end))

    # test for equality between two intervals
    # other is an interval object
    # returns a Boolean
    def __eq__(self, other):
        if self.beginning == other.beginning and self.end == other.end:
            return True
        return False

    # returns the length of this interval
    # returns an integer 
    def __len__(self):
        return self.end - self.beginning


    # determine if this interval overlaps with another
    # other is an interval object
    # returns a Boolean
    def overlap(self, other):
        if self == other:
            return True
        if (self.beginning < other.end) and (self.end > other.beginning):
            return True
        if (other.beginning < self.end) and (other.end > self.beginning):
            return True
        return False
        


    # determine the time in the intersection of this interval with another
    # other is an interval object
    # returns an Integer
    def intersection(self, other):
        if self.overlap(other) == False:
            return 0
        start = max(self.beginning, other.beginning)
        end = min(self.end, other.end)
        return end - start


    # determine the time in the union of this interval with another
    # other is an interval object
    # returns an Integer
    def union(self, other):
        return len(self) + len(other) - self.intersection(other)

# do NOT change main, it has been fully completed for you
def main():
    # read the two intervals
    line1 = sys.stdin.readline()
    line2 = sys.stdin.readline()
    line1 = line1.split(" ")
    line2 = line2.split(" ")

    interval1 = IntegerInterval(int(line1[0]), int(line1[1]))
    interval2 = IntegerInterval(int(line2[0]), int(line2[1]))

    # print the output
    print(interval1)
    print(interval2)
    print(len(interval1))
    print(len(interval2))
    print(interval1 == interval2)
    print(interval1.overlap(interval2))
    print(interval2.overlap(interval1))
    print(interval1.intersection(interval2))
    print(interval2.intersection(interval1))
    print(interval1.union(interval2))
    print(interval2.union(interval1))

if __name__ == "__main__":
    main()
