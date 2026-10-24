import mysql.connector

print("\nNOTICE: This app only connects to localhost. Additionally, the user \
must have database read and write privileges for this app to function.\n")

dataBase = mysql.connector.connect(
  host = "localhost",
  user = input("Enter username: "),
  passwd = input("Enter password: ")
)

cursorObject = dataBase.cursor()
cursorObject.execute("USE san_francisco_library_3NF")

insert = "INSERT INTO MAIN (\
PatronTypeCode,\
TotalCheckouts,\
TotalRenewals,\
AgeRange,\
HomeLibraryCode,\
CirculationActiveMonth,\
CirculationActiveYear,\
NotificationPreferenceCode,\
ProvidedEmailAddress,\
WithinSanFranciscoCounty,\
YearPatronRegistered)\
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
row = []

print("\nMENU\nEnter Visit\nExit\n")
while True:
    UserInput = input("> ")
    if UserInput == "Enter Visit":
        while True:
            UserInput = input("Enter Patron Code: ")
            try:
                UserInput = int(UserInput)
            except:
                print("Input Must Be An Integer")
                continue
            row.append(UserInput)
            break
        while True:
            UserInput = input("Enter Total Checkouts: ")
            try:
                UserInput = int(UserInput)
            except:
                print("Input Must Be An Integer")
                continue
            row.append(UserInput)
            break
        while True:
            UserInput = input("Enter Total Renewals: ")
            try:
                UserInput = int(UserInput)
            except:
                print("Input Must Be An Integer")
                continue
            row.append(UserInput)
            break
        row.append(input("Enter Age Range: "))
        row.append(input("Enter Home Library Code: "))
        row.append(input("Enter Circulation Active Month: "))
        while True:
            UserInput = input("Enter Circulation Active Year: ")
            try:
                UserInput = int(UserInput)
            except:
                print("Input Must Be An Integer")
                continue
            row.append(UserInput)
            break
        row.append(input("Enter Notification Preference Code: "))
        row.append(input("Did patron give their email address? (True/False): "))
        row.append(input("Is patron in San Francisco County? (True/False): "))
        while True:
            UserInput = input("Enter Year Patron Registered: ")
            try:
                UserInput = int(UserInput)
            except:
                print("Input Must Be An Integer")
                continue
            row.append(UserInput)
            break
        try:
            cursorObject.execute(insert, row)
            dataBase.commit()
            print("Input Accepted")
        except:
            print("ERROR: Foreign keys not respected. Insert aborted.")
    elif UserInput == "Exit":
        break
    else:
        print("Invalid Command")
        continue
    print("\nMENU\nEnter Visit\nExit\n")

print("Bye")
dataBase.close()