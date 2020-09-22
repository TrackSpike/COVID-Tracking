import json
import csv
from random import randint

names = []

with open('firstnames_lastnames.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)

    for line in csv_reader:
        names.append(line[0])

dmTemplate = {
    "source": "Instagram",
    "type": "Instagram DM",
    "sender": names[randint(0, 49)],
    "message": "this is my message"
}

print(json.dumps(dmTemplate, indent=2))

with open("custom.json", "w") as outfile:
    json.dump(dmTemplate, outfile)
