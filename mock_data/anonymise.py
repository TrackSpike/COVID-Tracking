import json
import hashlib
import sys

def main():
    file_path = sys.argv[1]
    with open(file_path) as f:
        json_data = json.load(f)
    for entry in json_data:
        hashobj = hashlib.sha1(entry['person'].encode())
        entry['person'] = hashobj.hexdigest()
    with open('anon_data.json', 'w') as outfile:
        json.dump(json_data, outfile)

if __name__ == "__main__":
    main()