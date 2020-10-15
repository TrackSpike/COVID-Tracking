from os import write
import matplotlib.pyplot as plt
import math
import sys
import datetime as dt
import json
import time


def main():
    filePath = sys.argv[1]
    with open(filePath) as f:
        json_data = json.load(f)
    result = calculate(json_data)
    write_file(result)
    plot_both(calculate(json_data),calculate_v1(json_data), True)

def calculate(dict):
    weights = json.load(open('algo_weights.json'))
    results = {}
    for entry in dict:
        try:
            time = dt.datetime.strptime(entry['time'],'%Y-%m-%dT%H:%M:%S.%f')
        except ValueError:
            time = dt.datetime.strptime(entry['time'],'%Y-%m-%dT%H:%M:%S')
        now = dt.datetime.strptime('2020-09-11', '%Y-%m-%d')
        dif = (now - time.replace(tzinfo=None)).days
        try:
            weight = weights[entry['type']]
            # for now t0 and weight are the same.
            value = trust_waning(weight,dif,weight)
            results[entry['person']] = results.get(entry['person'], 0) + value
        except KeyError:
            print(f'Cannot find type {entry["type"]} change json')
    return sorted(results.items(), key=lambda x: x[1], reverse=True)

def trust_waning(t0, dif, weight):
    time_weight = 0.01
    return max(t0 - dif * weight * time_weight * math.log(dif+1,10), 0)

def calculate_v1(dict):
    time_weight = 0.01
    weights = json.load(open('algo_weights.json'))
    results = {}
    for entry in dict:
        try:
            time = dt.datetime.strptime(entry['time'],'%Y-%m-%dT%H:%M:%S.%f')
        except ValueError:
            time = dt.datetime.strptime(entry['time'],'%Y-%m-%dT%H:%M:%S')
        now = dt.datetime.strptime('2020-09-11', '%Y-%m-%d')
        dif = (now - time.replace(tzinfo=None)).days
        try:
            weight = weights[entry['type']]
            value = max(weight - time_weight*dif*weight,0)
            results[entry['person']] = results.get(entry['person'], 0) + value
        except KeyError:
            print(f'Cannot find type {entry["type"]} change json')
    return sorted(results.items(), key=lambda x: x[1], reverse=True)

def write_file(data):
    time_str = time.strftime('%H_%M_%S', time.localtime())
    ego_filename = f'algo_v1_gen_{time_str}.json'
    with open(ego_filename , 'w+') as f:
        json.dump(data, f)

def plot_data(data, log=False):
    data = data[1:]
    y = [x[1] for x in data if x[1] != 0]
    x = list(range(len(y)))
    if log:
        plt.yscale('log')
    plt.scatter(x,y)
    plt.show()

def plot_both(data1, data2, log=False):
    data1 = data1[1:]
    y1 = [x[1] for x in data1 if x[1] != 0]
    x1 = list(range(len(y1)))
    data2 = data2[1:]
    y2 = [x[1] for x in data2 if x[1] != 0]
    x2 = list(range(len(y2)))
    if log:
        plt.yscale('log')
    plt.scatter(x1,y1,c='blue')
    plt.scatter(x2,y2,c='red')
    plt.show()

if __name__ == "__main__":
    main()