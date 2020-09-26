import json
import csv
from random import randint


def generateEntry(name, time):
    dmTemplate = {
        "source": "instagram",
        "time": time,
        "sender": name,
        "type": "instagram_dm",
        "message": "this is my dm message"
    }
    return dmTemplate


# READ NAMES FROM CSV
names = []
with open('firstnames_lastnames.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    for line in csv_reader:
        names.append(line[0])

# LIST OF POSSIBLE TIMESTAMPS
dates = ['2020-09-10T18:32:31+00:00',
         '2020-09-10T13:34:08+00:00',
         '2020-09-10T02:11:12+00:00',
         '2020-09-09T21:17:15+00:00',
         '2020-09-09T19:27:53+00:00']

data = {"data": []}

for i in range(100):
    curName = names[randint(0, 49)]
    curTime = dates[randint(0, 4)]
    data["data"].append(generateEntry(curName, curTime))

with open("custom.json", "w") as outfile:
    json.dump(data, outfile, indent=2)
