import mysql.connector

print("NOTICE: This app only connects to localhost!")
dataBase = mysql.connector.connect(
  host = "localhost",
  user = input("Enter username: "),
  passwd = input("Enter password: ")
)

cursorObject = dataBase.cursor()
UserInput = input("mysql> ")
while UserInput != "exit":
    cursorObject.execute(UserInput)
    UserInput = input("mysql> ")

print("Bye")
dataBase.close()