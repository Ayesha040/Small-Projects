#  File: Josephus.py

#  Description: Create a circular linked list to eliminate a group of siliders one at a time. 
#  start the eliminating at agiven start and remove at the nth number from that start until there is one soldier left 


import sys

class Link(object):
  def __init__(self, data):
    self.data = data
    self.next = None


class CircularList(object):
  # Constructor
  def __init__ ( self ):
    # the last element 
    self.tail = None

  # Insert an element (value) in the list
  def insert ( self, data ):
    new_data = Link(data)

    # empty list
    if self.tail is None: 
      # the end is now the new data
      self.tail = new_data
      new_data.next = new_data 

    else:
      #new data's next is what the old tails next is
      new_data.next = self.tail.next
      #old tails next is the new data
      self.tail.next = new_data 
      #asign new data as the tail now
      self.tail = new_data 



  # Find the Link with the given data (value)
  # or return None if the data is not there
  def find ( self, data ):
    #empty list
    if self.tail is None: 
        return None
    
    #start at the first data which is tail's next
    current = self.tail.next
    while current.data != data:
        current = current.next
        # we go through list and theres no data
        if current == self.tail.next: 
            return None
    return current
  
  # Delete a Link with a given data (value) and return the Link
  # or return None if the data is not there
  def delete ( self, data ):
    #empty list
    if self.tail is None: 
        return None
    
    # assign pointers
    current = self.tail.next
    previous = self.tail

    # search for the data
    while current.data != data:
        previous = current
        current = current.next
        # we look through data but dont find it
        if current == self.tail.next: 
            return None
        
    #deleting the only element 
    if current == self.tail and current.data == data:
        self.tail = None
        return current
    
    previous.next = current.next
    return current   


  # Delete the nth Link starting from the Link start
  # Return the data of the deleted Link AND return the
  # next Link after the deleted Link in that order
  def delete_after ( self, start, n ):
    #empty list
    if self.tail is None: 
        return None, None
    
    #assign the current
    current = start
    #move the current value to the nth - 1 value        
    for i in range(n-2):
      #move current
      current = current.next
    deleted_data = current.next
    #move cur next to the deleted's next
    current.next = current.next.next
    # if the last element of the list is being deleted, update the tail pointer
    if deleted_data == self.tail: 
      self.tail = current
    #deleted data and the new next
    return deleted_data.data, current.next

    

  # Return a string representation of a Circular List
  # The format of the string will be the same as the __str__
  # format for normal Python lists
  def __str__ ( self ):
    # empty list
    if self.tail is None: 
        return '[]'
    #getting the first element
    current = self.tail.next
    result = '[' + str(current.data)
    current = current.next
    while current != self.tail.next:
        result += ', ' + str(current.data)
        current = current.next
    result += ']'
    return result
  

def main():
  # read number of soldiers
  line = sys.stdin.readline()
  line = line.strip()
  num_soldiers = int (line)

  # read the starting number
  line = sys.stdin.readline()
  line = line.strip()
  start_count = int (line)

  # read the elimination number
  line = sys.stdin.readline()
  line = line.strip()
  elim_num = int (line)

  # your code
  # create list with soldiers
  soldiers = CircularList()
  for i in range(1, num_soldiers+1):
    soldiers.insert(i)
  
  
  # get the start
  start = soldiers.find(start_count)

  # kill until one is left
  while soldiers.tail != soldiers.tail.next:
    # delete the nth soldier after the start
    deleted_data, start = soldiers.delete_after(start, elim_num)
    # output the deleted soldier
    print(deleted_data)

  # result of who survived
  print(soldiers.tail.next.data)

if __name__ == "__main__":
  main()
