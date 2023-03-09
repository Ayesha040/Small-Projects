#  File: Meet.py

#  Description: Determine earlist meet time interval for two people

#  Student Name:

#  Student UT EID:

#  Course Name: CS 313E

#  Unique Number: 86610

import sys

def earliestPossibleMeeting(person1, person2, duration):
    # find the earliest meeting time interval that satisfies the duration requirement
    for i in range(len(person1)):
        for j in range(len(person2)):
            if person1[i][1] < person2[j][0]:
                continue
            elif person2[j][1] < person1[i][0]:
                continue
            else:
                start = max(person1[i][0], person2[j][0])
                end = min(person1[i][1], person2[j][1])
                if end - start >= duration:
                    return [start, start+duration]

    # no meeting interval found
    return []







def main():
        #test_cases()

	# read the input data and create a list of lists for each person
	f = sys.stdin
	# read in the duration
	dur = int(f.readline().strip())
	# person 1's number of avalible slots
	num1 = int(f.readline().strip())
	p1 = []
	for x in range(num1):
		line = f.readline()
		l = line.strip().split()
		tmp = [int(l[0]), int(l[1])]
		p1.append(tmp)

	# person 2's number of avalible slots
	num2 = int(f.readline().strip())
	p2 = []
	for x in range(num2):
		line = f.readline()
		l = line.strip().split()
		tmp = [int(l[0]), int(l[1])]
		p2.append(tmp)

	print(earliestPossibleMeeting(p1,p2,dur))

if __name__ == "__main__":
  main()
