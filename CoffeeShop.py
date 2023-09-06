
# 1 Espresso, 
# 2 Americano
# 3 Latte Macchiato, 
# 4 Black Tea
# 5 Green Tea
# 6 Yellow Tea.
# 1 Espresso, 
# 2 Americano
# 3 Latte Macchiato, 
# 4 Black Tea
# 5 Green Tea
# 6 Yellow Tea.

class Beverage:
    def __init__(self, name, price, caffeine, calories):
        self.name = name
        self.price = price
        self.caffeine = caffeine
        self.calories = calories

    def __str__(self):
        return f'{self.name} costs ${self.price:.2f}: {self.calories} calories, {self.caffeine}mg caffeine'

class Latte (Beverage):
    def __init__(self, name, price, caffeine, calories, lactose):
        super().__init__(name, price, caffeine, calories)
        self.lactose = str(lactose)

    def __str__(self):
        return f'{self.name} costs ${self.price:.2f}: {self.calories} calories, {self.caffeine}mg caffeine, {self.lactose} lactose'

class Tea (Beverage):
    def __init__(self, name, price, caffeine, calories, color):
        super().__init__(name, price, caffeine, calories)
        self.color = str(color)

    def __str__(self):
        return f'{self.name} costs ${self.price:.2f}: {self.calories} calories, {self.caffeine}mg caffeine, {self.color} color'

class Condiments():
    def __init__(self, name, amount, extra_price):
        self.name = name
        self.amount = amount
        self.extra_price = extra_price
        self.total =  float(extra_price) * amount

    def __str__(self):
        return f'{self.amount} unit added of {self.name} at ${self.extra_price:.2f} each. For a total of {self.total:.2f}'

def print_welcome_messages():
    print()
    print("************************************")
    print("Welcome to THE DRINK VENDING MACHINE")
    print("    (っ＾▿＾)۶🍵🍵🍵🍵🍵🍵🍵    ")
    print("************************************")
    print()
    print("What would you like to drink?")
    print("1 Coffee")
    print("2 Tea")


def get_drink_choice():
    return input("Enter your selection: ")


def process_coffee_choice(command):
    print("what type of coffee?")
    print("1 Espresso")
    print("2 Americano")
    print("3 Latte Macchiatio")
    print()
    command = input("Enter your selection: ")
    print()
    if command == "1":
        bev = Beverage("Espresso", 4.00, 20, 200)
        print(bev)
    elif command == "2":
        bev = Beverage("Americano", 4.00, 30, 300)
        print(bev)
    elif command == "3":
        bev = Latte("Latte Macchiatio", 4.00, 30, 200, 150)
        print(bev)
    return bev


def process_tea_choice(command):
    print("what type of tea?")
    print("1 Black Tea")
    print("2 Green Tea")
    print("3 Yellow Tea")
    print()
    command = input("Enter your selection: ")
    print()
    if command == "1":
        bev = Tea("Black Tea", 4.00, 20, 200, "Black")
        print(bev)
    elif command == "2":
        bev = Tea("Green Tea", 4.00, 20, 200, "Green")
        print(bev)
    elif command == "3":
        bev = Tea("Yellow Tea", 4.00, 20, 200, "Yellow")
        print(bev)
    else:
        print("Invalid.")
    return bev

def print_add_condiments_messages():
    print("Would you like to add milk or sugar?")
    print("You may add up to 3 units")
    print("1 Milk")
    print("2 Sugar")
    print("3 None")
    print()

def get_condiments_choice():
    return str(input("Enter your selection: "))

def get_condiments_units():
    return int(input("Enter number of units (1-3): "))

def process_milk_choice(total_units, show_units, total_price):
    milk_units = get_condiments_units()
    if total_units + milk_units > 3:
        print("You have exceeded the max number of units")
        print()
        return total_units, show_units, total_price
    else:
        total_units += milk_units
        show_units -= milk_units
        milk = Condiments("Milk", milk_units, 0.75)
        total_price += 0.75 * milk_units
        print(milk)
        return total_units, show_units, total_price

def process_sugar_choice(total_units, show_units, total_price):
    sugar_units = get_condiments_units()
    if total_units + sugar_units > 3:
        print("You have exceeded the max number of units")
        print()
        return total_units, show_units, total_price
    else:
        total_units += sugar_units
        show_units -= sugar_units
        sugar = Condiments("Sugar", sugar_units, 0.25)
        total_price += 0.25 * sugar_units
        print(sugar)
        return total_units, show_units, total_price


def print_order_summary(bev, total_price):
    print("You ordered", bev.name, "and your total price is: ", total_price)

def main():
    print_welcome_messages()
    command = get_drink_choice()
    print()
    
    if command == "1":
        bev = process_coffee_choice(command)
    elif command == "2":
        bev = process_tea_choice(command)
    else:
        print("Invalid.")
        return

    total_price = bev.price
    total_units = 0
    show_units = 3

    while total_units < 3:
        print_add_condiments_messages()
        command = get_condiments_choice()
        if command == "1":
            total_units, show_units, total_price = process_milk_choice(total_units, show_units, total_price)
        elif command == "2":
            total_units, show_units, total_price = process_sugar_choice(total_units, show_units, total_price)
        elif command == "3":
            break
        else:
            print("Invalid. Please enter a number between 1 and 3.")

    print_order_summary(bev, total_price)
    print("Thank you for stopping by!")
    


while True:
    main()
    order_again = input("Do you want to order again? (Y/N)")
    if order_again.upper() != "Y":
        break
