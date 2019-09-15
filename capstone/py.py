age = input("How old are you?")
if int(age) <= 5 :
    print("Your total is $0.")
elif (int(age) >= 6) and (int(age) <= 59):
    print("Your total is $20.")
elif  int(age) >= 60:
    print("Your total is $10.")