input = open("input1.txt", "r")
output = open("output1.txt", "a")

relationships, spl, nameTable, name, nameAttribute = [], [], [], [], []

x = input.read().split("\n" )
relationships.append(x[len(x) - 2].split(", "))
relationships.append(x[len(x) - 1].split(", "))

for i in range(0, len(x) - 2):
    spl.append(x[i].split(" ("))

for i in range(len(spl)):
    nameTable.append(spl[i][0])

for i in range(len(spl)):
    name.append(spl[i][1].split(")"))

for i in range(len(name)):
    nameAttribute.append(name[i][0])

for i in relationships:
    if (i[1] == "1-n"):
        for j in range(len(nameTable)):
            if (nameTable[j] == i[0]):
                output.write(nameTable[j] + "(" + nameAttribute[j] + ")\n")
                nameAttribute_1 = nameAttribute[j].split(", ")
                n = nameAttribute_1[0]
                table_1 = i[0]
            if (nameTable[j] == i[2]):
                output.write(nameTable[j] + '(' + nameAttribute[j] + ', ' + n.replace('pk', 'fk') +')\n')
                table_2 = i[2]
