#  File: employee.py
#  Description:

import sys

# Employee has the following properties: name, id and salary
class Employee ():

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.id = kwargs.get("id")
        self.salary = kwargs.get("salary")

    def __str__(self):
        return f"Employee\n{self.name} ,{self.id} ,{self.salary}"


############################################################
############################################################
############################################################
#A Permanent Employee has benefits that he/she can select from [”health insurance”], [”retirement”], 
# or both [”retirement”, ”health insurance”]. Implement a method cal salary() to calculate the actual 
# salary based on selected benefits. If benefits =[”health insurance”] then return salary ∗0.9, if 
# [”retirement”] then salary ∗0.8 and if benefits =[”retirement”, ”health insurance”] is selected then salary ∗0.7.
class Permanent_Employee(Employee):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.benefits = kwargs.get("benefits")
        
    def cal_salary(self): 
        if self.benefits == ["health_insurance"]:
            return self.salary * 0.9
        elif self.benefits == ["retirement"]:
            return self.salary * 0.8
        elif self.benefits == ["retirement","health_insurance"]:
            return self.salary * 0.7
        


    def __str__(self):
        return f"Permanent_Employee\n{self.name} ,{self.id} ,{self.salary} ,{self.benefits}"


############################################################
############################################################
############################################################
#A manager is a special type of employee and is paid with a bonus payment in 
# addition to his/her main salary. Manager has a property bonus which adds to 
# his/her main salary on top. Implement a method cal salary() to return salary + bonus
class Manager(Permanent_Employee):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.bonus = kwargs.get("bonus")
        

    def cal_salary(self):
        salary = self.salary
        return float(salary + self.bonus)

    def __str__(self):
        return f"Manager\n{self.name} ,{self.id} ,{self.salary} , {self.bonus}"


############################################################
############################################################
############################################################
# has a property ”hours” which is the working hours per mount. The salary property 
# represents the amount that a temporary employee is paid per hour. Implement a method 
# cal salary() to calculate the actual salary by returning salary ∗hours
class Temporary_Employee (Employee):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.hours = kwargs.get("hours")

    def cal_salary(self):
        salary = self.salary
        return float(salary * self.hours)

    def __str__(self):
           return f"Permanent_Employee\n{self.name} ,{self.id} ,{self.salary} ,{self.hours}"


############################################################
############################################################
############################################################
# Consultant is a Temporary Employee and has in addition to travel. The property travel
#  represents number of travel trips that a Consultant has to do and is paid additionally
#  1000 dollar for each travel. Implement a method cal salary() to calculate the actual 
# salary similar to a Temporary Employee with an additional payment of travel ∗1000. 
# (Tip: Try to reuse your code as much as possible to avoid having duplicated code)
class Consultant (Temporary_Employee) :

    def __init__(self, **kwargs):
        self.travel = kwargs.get("travel")
        super().__init__(**kwargs)

    def cal_salary(self):
        salary = Temporary_Employee.cal_salary(self)
        return float(salary + self.travel * 1000)


    def __str__(self):
        return f"Consultant\n{self.name} ,{self.id} ,{self.salary} ,{self.hours} ,{self.travel}"

############################################################
############################################################
############################################################
#A Consultant Manager has travel, hours of work and bonus payment. Implement 
# a method cal salary() to calculate the salary similar to a Temporary Employee 
# and Consultant with an additional bonus payment. The cal salary() method should 
# return salary ∗hours + travel ∗1000 + bonus
class Consultant_Manager (Manager, Consultant) :
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def cal_salary(self):
        return float((self.salary*self.hours)+(self.travel * 1000) + self.bonus)

    def __str__(self):
        return f"Consultant Manager\n{self.name} ,{self.id} ,{self.salary} ,{self.bonus} ,{self.hours} ,{self.travel}"


############################################################
############################################################
############################################################


###### DO NOT CHANGE THE MAIN FUNCTION ########

def main():

    chris = Employee(name="Chris", id="UT1")
    print(chris, "\n")

    emma = Permanent_Employee(name="Emma", id="UT2", salary=100000, benefits=["health_insurance"])
    print(emma, "\n")

    sam = Temporary_Employee(name="Sam", id="UT3", salary=100,  hours=40)
    print(sam, "\n")

    john = Consultant(name="John", id="UT4", salary=100, hours=40, travel=10)
    print(john, "\n")

    charlotte = Manager(name="Charlotte", id="UT5", salary=1000000, bonus=100000)
    print(charlotte, "\n")

    matt = Consultant_Manager(name="Matt", id="UT6", salary=1000, hours=40, travel=4, bonus=10000)
    print(matt, "\n")

    ###################################
    print("Check Salaries")

    print("Emma's Salary is:", emma.cal_salary(), "\n")
    emma.benefits = ["health_insurance"]

    print("Emma's Salary is:", emma.cal_salary(), "\n")
    emma.benefits = ["retirement", "health_insurance"]

    print("Emma's Salary is:", emma.cal_salary(), "\n")

    print("Sam's Salary is:", sam.cal_salary(), "\n")

    print("John's Salary is:", john.cal_salary(), "\n")

    print("Charlotte's Salary is:", charlotte.cal_salary(), "\n")

    print("Matt's Salary is:",  matt.cal_salary(), "\n")


if __name__ == "__main__":
  main()
