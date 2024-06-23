# Quick object demo

class AddressBookEntry(object):
    version = 0.1

    def __init__(self, name, phone):
        self.name = name
        self.phone = phone
            
    def update_phone(self, phone):
        self.phone = phone

    def __str__(self) -> str:
        return f"Name: {self.name}, phone: {self.phone}"

# Instantiate the an object
me = AddressBookEntry("Koko", "1234")
print(me)
me.update_phone("1010")
print(me)

# Subclassing
# Continuing our previous example, we now create an
# employer address book entry class.
class EmployeeAddressBookEntry(AddressBookEntry):
    def __init__(self, name, phone, id, social):
        AddressBookEntry.__init__(self, name, phone)
        self.empid = id
        self.ssn = social

    def __str__(self) -> str:
        s = AddressBookEntry.__str__(self)
        s += f", Id: {self.empid}, SocialNum: {self.ssn}"
        return s
    
# Instantiate an employee
me = EmployeeAddressBookEntry("Pumpkin", "3939", "ABC001", "A123B")
print(me)
me.update_phone("5959")
print(me)