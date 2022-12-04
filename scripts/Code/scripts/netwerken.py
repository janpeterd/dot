#!/usr/bin/env python3

givenHost = input("Enter host ip address (without prefix): ")
# givenHost = "192.168.1.138"
givenPrefix = int(input("Enter host prefix: "))
# givenPrefix = 24


hostSplit = givenHost.split('.')
amountIP = 2 ^ (32 - givenPrefix)
subnetMask = []
numberToAdd = 0
if givenPrefix > 23:
    subnetMask.append(0b11111111)
    subnetMask.append(0b11111111)
    subnetMask.append(0b11111111)
    if givenPrefix - 24 > 0:
        ones_to_add = givenPrefix - 24
        if ones_to_add < 8:
            binary_string = ""
            for i in range(ones_to_add):
                binary_string += "1"
            while len(binary_string) < 8:
                binary_string += "0"
            for i in range(len(binary_string)):
                if binary_string[i] == "1":
                    numberToAdd += 2 ** (7-i)
            subnetMask.append(numberToAdd)

elif givenPrefix > 15:
    subnetMask.append(0b11111111)
    subnetMask.append(0b11111111)
    if givenPrefix - 16 > 0:
        ones_to_add = givenPrefix - 16
        if ones_to_add < 8:
            binary_string = ""
            for i in range(ones_to_add):
                binary_string += "1"
            while len(binary_string) < 8:
                binary_string += "0"
            for i in range(len(binary_string)):
                numberToAdd = 2 ** (7-i)
            subnetMask.append(numberToAdd)

elif givenPrefix > 7:
    subnetMask.append(0b11111111)
    if givenPrefix - 8 > 0:
        ones_to_add = givenPrefix - 16
        if ones_to_add < 8:
            binary_string = ""
            for i in range(ones_to_add):
                binary_string += "1"
            while len(binary_string) < 8:
                binary_string += "0"
            for i in range(len(binary_string)):
                numberToAdd = 2 ** (7-i)
            subnetMask.append(numberToAdd)


while len(subnetMask) < 4:
    subnetMask.append(0b00000000)

for i in range(len(hostSplit)):
    hostSplit[i] = int(hostSplit[i])

# print(hostSplit)
# print(subnetMask)

networkIP = []
for i in range(len(hostSplit)):
    nwIP = hostSplit[i] & subnetMask[i]
    networkIP.append(nwIP)

# print(networkIP)

firstHost = []
for i in networkIP:
    firstHost.append(i)
firstHost[-1] += 1
# print(firstHost)


lastHost = []
for i in networkIP:
    lastHost.append(i)
lastHost[-1] = 2 ** (32 - givenPrefix) - 3
lastHost[-1] += firstHost[-1]

broadCast = []
for i in networkIP:
    broadCast.append(i)
broadCast[-1] = 2 ** (32 - givenPrefix) -2
broadCast[-1] += firstHost[-1]


# print(lastHost)

# output

print("Host address, with prefix /" + str(givenPrefix))
for i in range(len(hostSplit)):
    if i != len(hostSplit) - 1:
        print(hostSplit[i], end=".")
    else:
        print(hostSplit[i], end="/")
        print(givenPrefix)

print("Subnet Mask")
for i in range(len(subnetMask)):
    if i != len(subnetMask) - 1:
        print(subnetMask[i], end=".")
    else:
        print(subnetMask[i])

print("Network Address")
for i in range(len(networkIP)):
    if i != len(networkIP) - 1:
        print(networkIP[i], end=".")
    else:
        print(networkIP[i])

print("Broadcast Address")
for i in range(len(broadCast)):
    if i != len(broadCast) - 1:
        print(broadCast[i], end=".")
    else:
        print(broadCast[i])

print("First Host")
for i in range(len(firstHost)):
    if i != len(firstHost) - 1:
        print(firstHost[i], end=".")
    else:
        print(firstHost[i])

print("Last Host")
for i in range(len(lastHost)):
    if i != len(lastHost) - 1:
        print(lastHost[i], end=".")
    else:
        print(lastHost[i])
