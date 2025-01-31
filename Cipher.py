#This code defines an encrypt function that takes a string, pads it with asterisks to form a perfect square, and then places the characters into a 2D table. The table is prepared for further operations, such as rotating it for encryption.


import math
import sys

def encrypt ( strng ):
  #Let L be the length of the original message
  length = len(strng)
    #M the smallest square
  smallest_square = int(math.ceil(math.sqrt(length))) ** 2
  #table of size K × K, where K2 = M
  table_size = int(math.ceil(math.sqrt(smallest_square)))
  #Add (M-L) asterisks to the message
  asterisks = smallest_square - length
  new_string = strng + "*" * asterisks
    
  #create table
  table = []
  for i in range(table_size):
    #add rows
    table.append([])
    for j in range(table_size):
        #adds the letters by index
        letter = new_string[j + i * table_size]
        table[i].append(letter)
    
  #rotate table
  rotated_table = []

  for i in range(table_size):
    rotated_table.append([])
    for j in range(table_size):
      rotated_table[i].append(table[table_size - j - 1][i])

  #change to string 
  encrypted_string = ""
  for i in range(table_size):
    for j in range(table_size):
      if rotated_table[i][j] != '*':
        encrypted_string = encrypted_string + rotated_table[i][j]
  return encrypted_string


def decrypt(strng):
    length = len(strng)
    smallest_square = int(math.ceil(math.sqrt(length))) ** 2
    table_size = int(math.ceil(math.sqrt(smallest_square)))
    asterisks = smallest_square - length
    new_string = strng + "*" * asterisks
    #create empty table
    encrypt_table = [[None for i in range(table_size)] for j in range(table_size)]
    
    #start by adding asterisks from the bottom left corner going up if there are asterisks
    if asterisks > 0:
        index = 0
        for i in range(table_size):
            for j in range(table_size - 1, -1, -1):
                if asterisks > 0:
                    encrypt_table[j][i] = "*"
                    asterisks -= 1
                else:
                    break
        #then add the charcaters from the string
        for i in range(table_size):
            for j in range(table_size):
                if encrypt_table[i][j] is None:
                    encrypt_table[i][j] = strng[index]
                    index += 1
    #else just add the letters from the string          
    else:
        for i in range(table_size):
            for j in range(table_size):
                encrypt_table[i][j] = strng[i * table_size + j]

    #rotate 90 degrees three times           
    for _ in range(3):
        rotated_table = []
        for i in range(table_size):
            rotated_table.append([])
            for j in range(table_size):
                rotated_table[i].append(encrypt_table[table_size - j - 1][i])
        encrypt_table = rotated_table
    
    #convert to string   
    decrypt_string = ""
    for i in range(table_size):
        for j in range(table_size):
            decrypt_string = decrypt_string + encrypt_table[i][j]
    return decrypt_string.replace("*", "")
    
  
def main():
  # read the strings P and Q from standard input
    data = sys.stdin.read() 
    data_list = data.split("\n")
    p = data_list[0]
    q = data_list[1]

    # encrypt the string P
    encrypted_p = encrypt(p)
    
    # decrypt the string Q
    decrypted_q = decrypt(q)

  # print the encrypted string of P
  # and the decrypted string of Q
    print(encrypted_p)
    print(decrypted_q)

if __name__ == "__main__":
  main()

