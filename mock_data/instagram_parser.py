import json
import sys
import time

def main():
    likes = parse_likes()['data']
    messages = parse_messages()['data']
    time_str = time.strftime('%H_%M_%S', time.localtime())
    filename = f'instagram_gen_{time_str}.json'
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
            d['time'] = like[0]
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
                d['time'] = message['created_at']
                d['person'] = message['sender']
                if len(chat['participants']) > 2:
                    d['type'] = 'instagram_group_message'
                else:
                    d['type'] = 'instagram_direct_message'
                new_data['data'].append(d)
    return new_data

if __name__ == "__main__":
    main()