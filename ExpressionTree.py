#  File: ExpressionTree.py

#  Description:
import sys

operators = ['+', '-', '*', '/', '//', '%', '**']

class Stack (object):
    def __init__(self):
        self.stack = []

    def push(self, data):
        self.stack.append (data)

    def pop(self):
        if(not self.is_empty()):
            return self.stack.pop()
        else:
            return None

    def is_empty(self):
        return len(self.stack) == 0

class Node (object):
    def __init__ (self, data = None, lChild = None, rChild = None):
        self.data = data
        self.lChild = lChild
        self.rChild = rChild

class Tree (object):
    def __init__ (self):
        self.root = None

    # def print_tree(self):
    #     self._print_tree_helper(self.root)

    # def _print_tree_helper(self, node, indent=0):
    #     if node is not None:
    #         # print right subtree
    #         self._print_tree_helper(node.rChild, indent + 4)

    #         # print node
    #         print(' ' * indent, node.data)

    #         # print left subtree
    #         self._print_tree_helper(node.lChild, indent + 4)
    
    
    def create_tree (self, expr):
        tokens = expr.split()
        stack = Stack()
        current_node = Node()
        self.root = current_node
        
        for token in tokens:
            if token == "(":
                new_node = Node()
                current_node.lChild = new_node
                stack.push(current_node)
                current_node = new_node
            elif token == ")":
                if not stack.is_empty():
                    current_node = stack.pop()
            elif token in operators:
                current_node.data = token
                new_node = Node()
                current_node.rChild = new_node
                stack.push(current_node)
                current_node = new_node
            else:
                current_node.data = token
                parent = stack.pop()
                current_node = parent
                if current_node is not None:
                    current_node.rChild = parent.rChild

        
    # this function should evaluate the tree's expression
    # returns the value of the expression after being calculated
    def evaluate (self, aNode):
        # if empty return zero
        if aNode is None:
            return 0
        
        #if the root is the only node then return its data
        if aNode.lChild is None and aNode.rChild is None:
            return float(aNode.data)
        
        # using recursion to evaluate 
        left = self.evaluate(aNode.lChild)
        right = self.evaluate(aNode.rChild)

        # doing the math
        if aNode.data == '+':
            return left + right
        elif aNode.data == '-':
            return left - right
        elif aNode.data == '*':
            return left * right
        elif aNode.data == '/':
            return left / right
        elif aNode.data == '//':
            return left // right
        elif aNode.data == '%':
            return left % right
        elif aNode.data == '**':
            return left ** right
        else:
            return 0
    
# this function should generate the preorder notation of 
    # the tree's expression
    # returns a string of the expression written in preorder notation
    def pre_order(self, aNode):
        if aNode is None:
            return ''
        else:
            left = self.pre_order(aNode.lChild)
            right = self.pre_order(aNode.rChild)
            return str(aNode.data) + ' ' + left + right

    # this function should generate the postorder notation of 
    # the tree's expression
    # returns a string of the expression written in postorder notation
    def post_order(self, aNode):
        if aNode is None:
            return ''
        else:
            left = self.post_order(aNode.lChild)
            right = self.post_order(aNode.rChild)
            return left + right + str(aNode.data) + ' '


# you should NOT need to touch main, everything should be handled for you
def main():
    # read infix expression
    line = sys.stdin.readline()
    expr = line.strip()
 
    tree = Tree()
    tree.create_tree(expr)
    
    
    # evaluate the expression and print the result
    print(expr, "=", str(tree.evaluate(tree.root)))

    # get the prefix version of the expression and print
    print("Prefix Expression:", tree.pre_order(tree.root).strip())

    # get the postfix version of the expression and print
    print("Postfix Expression:", tree.post_order(tree.root).strip())

if __name__ == "__main__":
    main()
