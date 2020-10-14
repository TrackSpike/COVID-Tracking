import json
import datetime as dt
import time
import sys
import time
import os.path
from os import path

# How to use: this file generates formated data for algov1
# 2 parameters, 1st is location of snap data folder
# 2nd is the location of the output file. Use this to append new data or 
# specify a name for the output.

def main():
    messages = parse_snaps()['data']
    time_str = time.strftime('%H_%M_%S', time.localtime())
    filename = f'snapchat_datagen_{time_str}.json'
    if sys.argv[2]:
        if path.exists(sys.argv[2]):
            with open(sys.argv[2], 'r') as f:
                old = json.load(f)
            with open(sys.argv[2], 'w+') as f:
                json.dump(old + messages, f)
        else:
            with open(sys.argv[2], 'w+') as f:
                json.dump(messages, f)
    else:
        with open(filename, 'w+') as f:
            json.dump(messages, f)

def parse_snaps():
    new_data = {'data':[]}
    filename = sys.argv[1] + '/json/snap_history.json'
    with open(filename) as f:
        json_data = json.load(f)
        for snap in json_data['Received Snap History']:
            d = {}
            d['source'] = 'snapchat'
            d['time'] = format_time(snap['Created'])
            d['person'] = snap['From']
            if snap['Media Type'] == 'IMAGE':
                d['type'] = 'snapchat_got_image'
            elif snap['Media Type'] == 'VIDEO':
                d['type'] = 'snapchat_got_video'
            else:
                d['type'] = 'snapchat_got_other'
            new_data['data'].append(d)
        for snap in json_data['Sent Snap History']:
            d = {}
            d['source'] = 'snapchat'
            d['time'] = format_time(snap['Created'])
            d['person'] = snap['To']
            if snap['Media Type'] == 'IMAGE':
                d['type'] = 'snapchat_sent_image'
            elif snap['Media Type'] == 'VIDEO':
                d['type'] = 'snapchat_sent_video'
            else:
                d['type'] = 'snapchat_sent_other'
            new_data['data'].append(d)
    return new_data

def format_time(time_string):
    time_object = time.strptime(time_string, '%Y-%m-%d %H:%M:%S %Z')
    return time.strftime('%Y-%m-%dT%H:%M:%S', time_object)

if __name__ == "__main__":
    main()