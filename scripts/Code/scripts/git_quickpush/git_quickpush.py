import os
from termcolor import colored

commit_message = input("Enter commit message: ")
if commit_message == "":
    commit_message = "regular commit"

print("--------------------")
print("Running " + colored("Commands", 'green'))
print("--------------------")

print(colored("git add .", 'green'))
os.system("git add .")
print(colored("git commit -m " + "\'" + commit_message + "\'", 'green'))
os.system("git commit -m" + "\'" + commit_message + "\'")
print(colored("git push", 'green'))
os.system("git push")
