# File: Anagrams.py

# Description: A program to group strings into anagram families

# Student Name: ayesha faheem

# Student UT EID: af35545

# Course Name: CS 313E

# Unique Number: 52020

# Output: True or False
def are_anagrams(str1, str2):
    return sorted(str1) == sorted(str2)


# Input: lst is a list of strings comprised of lowercase letters only
# Output: the number of anagram families formed by lst
def anagram_families(lst):
    # create an empty dictionary to store the anagram families
    families = {}   
    # iterate over each word in the input list
    for word in lst:
        added = False
        # iterate over the keys in the families dictionary
        for key in families:
            # check if the current word is an anagram of the current key
            if are_anagrams(word, key):
                # add the word to the list of anagrams for the current key
                families[key].append(word)
                added = True
        # if the word did not fit into any existing anagram family, create a new one
        if not added:
            families[word] = [word]
    # return the number of anagram families
    return len(families)


def main():
    # read the number of strings in the list
    num_strs = int(input())

    # add the input strings into a list
    lst = []
    for i in range(num_strs):
        lst += [input()]

    # compute the number of anagram families
    num_families = anagram_families(lst)

    # print the number of anagram families
    print(num_families)

if __name__ == "__main__":
    main()
