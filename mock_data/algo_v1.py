import matplotlib.pyplot as plt
import sys
import datetime as dt
import json
import time


def main():
    filePath = sys.argv[1]
    with open(filePath) as f:
        json_data = json.load(f)
    result = calculate(json_data)
    plot_data(result)
    plot_data(result, True)

def calculate(dict):
    time_weight = 0.01
    weights = json.load(open('algo_weights.json'))
    results = {}
    for entry in dict:
        try:
            time = dt.datetime.strptime(entry['time'],'%Y-%m-%dT%H:%M:%S.%f%z')
        except ValueError:
            time = dt.datetime.strptime(entry['time'],'%Y-%m-%dT%H:%M:%S%z')
        dif = (dt.datetime.now() - time.replace(tzinfo=None)).days
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
        json.dump(calculate(data), f)

def plot_data(data, log=False):
    data = data[1:]
    y = [x[1] for x in data if x[1] != 0]
    x = list(range(len(y)))
    if log:
        plt.yscale('log')
    plt.scatter(x,y)
    plt.show()

if __name__ == "__main__":
    main()