import json
import time
import datetime as dt
import sys
import time
import os.path
from os import path

# How to use: this file generates formated data for algov1
# 2 parameters, 1st is location of insta data folder
# 2nd is the location of the output file. Use this to append new data

def main():
    likes = parse_likes()['data']
    messages = parse_messages()['data']
    time_str = time.strftime('%H_%M_%S', time.localtime())
    filename = f'instagram_gen_{time_str}.json'
    if sys.argv[2]:
        if path.exists(sys.argv[2]):
            with open(sys.argv[2], 'r') as f:
                old = json.load(f)
            with open(sys.argv[2], 'w+') as f:
                json.dump(old + likes + messages, f)
        else:
            with open(sys.argv[2], 'w+') as f:
                json.dump(likes + messages, f)
    else:
        with open(filename, 'w+') as f:
            json.dump(likes + messages, f)

def parse_likes():
    new_data = {'data':[]}
    filename = sys.argv[1] + 'likes.json'
    with open(filename) as f:
        json_data = json.load(f)
        for like in json_data['media_likes']:
            d = {}
            d['source'] = 'instagram'
            d['time'] = format_time(like[0])
            d['person'] = like[1]
            d['type'] = 'instagram_like'
            new_data['data'].append(d)
    return new_data

def parse_messages():
    new_data = {'data':[]}
    filename = sys.argv[1] + 'messages.json'
    with open(filename) as f:
        json_data = json.load(f)
        for chat in json_data:
            for message in chat['conversation']:
                d = {}
                d['source'] = 'instagram'
                d['time'] = format_time(message['created_at'])
                d['person'] = message['sender']
                if len(chat['participants']) > 2:
                    d['type'] = 'instagram_group_message'
                else:
                    d['type'] = 'instagram_direct_message'
                new_data['data'].append(d)
    return new_data

def format_time(time_string):
    try:
        time_obj = time.strptime(time_string,'%Y-%m-%dT%H:%M:%S.%f%z')
    except ValueError:
        time_obj = time.strptime(time_string,'%Y-%m-%dT%H:%M:%S%z')
    return time.strftime('%Y-%m-%dT%H:%M:%S', time_obj)

if __name__ == "__main__":
    main()