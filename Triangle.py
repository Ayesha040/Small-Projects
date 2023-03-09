# File: Triangle.py

# Description: A basic 2D Triangle class


import sys
import math

TOL = 0.01

class Point (object):
    # constructor
    def __init__(self, x = 0, y = 0):
        self.x = x
        self.y = y

    # get the distance to another Point object
    def dist (self, other):
        dx = self.x - other.x
        dy = self.y - other.y
        return ((dx ** 2) + (dy ** 2)) ** 0.5
    


class Triangle (object):
    # constructor
    def __init__(self, PointA, PointB, PointC):
        self.PointA = PointA
        self.PointB = PointB
        self.PointC = PointC

    # check congruence of Triangles with equality
    # returns True or False (bolean)
    def __eq__(self, other):
        side_self = [self.PointA.dist(self.PointB), self.PointB.dist(self.PointC), self.PointA.dist(self.PointC)]
        side_other = [other.PointA.dist(other.PointB), other.PointB.dist(other.PointC), other.PointA.dist(other.PointC)]
        return sorted(side_self) == sorted(side_other)


    # returns whether or not the triangle is valid
    # returns True or False (bolean)
    def is_triangle(self):
        AB = self.PointA.dist(self.PointB)
        AC = self.PointA.dist(self.PointC)
        BC = self.PointB.dist(self.PointC)
        return (AB + AC > BC + TOL) and (AB + BC > AC + TOL) and (AC + BC > AB + TOL)


    # return the area of the triangle:
    def area(self):
        x1, y1 = self.PointA.x, self.PointA.y
        x2, y2 = self.PointB.x, self.PointB.y
        x3, y3 = self.PointC.x, self.PointC.y
        area = abs(x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2
        return float(area)


######################################################
# The code below is filled out for you, DO NOT EDIT. #
######################################################

# takes a string of coordinates and changes it to a list of Points
def get_points(coords_str):
    coords = [float(c) for c in coords_str.split(" ")]
    return [Point(c[0], c[1]) for c in zip(*[iter(coords)]*2)]

def main():
    # read the two triangles
    pointsA = get_points(sys.stdin.readline().strip())
    pointsB = get_points(sys.stdin.readline().strip())

    triangleA = Triangle(pointsA[0], pointsA[1], pointsA[2])
    triangleB = Triangle(pointsB[0], pointsB[1], pointsB[2])

    # Print final output
    print(triangleA.area())
    print(triangleB.area())
    print(triangleA.is_triangle())
    print(triangleB.is_triangle())
    print(triangleA == triangleB)

if __name__ == "__main__":
    main()
