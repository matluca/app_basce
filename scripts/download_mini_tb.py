#!/usr/bin/env python3

import os
import requests
import yaml

collections = [
    'predictions'
]

names = [
    'Admin',
    'Ale',
    'Enrico',
    'Luca',
    'Magu',
    'Melo',
    'Nic',
    'Teo'
]

out_file_name = 'minitb_2022.yaml'


def get_di_token():
    pwd = os.getenv('PASSWORD')
    if pwd is None:
        pwd = ""
    auth_url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDiXzh_G3clIgnzU_k5tSPmSSOFL2L8-IM'
    auth_data = f'{{"email":"firebase@matluca.com","password":"{pwd}","returnSecureToken":true}}'
    auth_headers = {'Content-Type': 'application/json'}
    r = requests.post(auth_url, data=auth_data, headers=auth_headers)
    return (r.json())['idToken']


def download_minitb():
    try:
        id_token = get_di_token()
    except KeyError:
        print('Could not get id token')
        return
    headers = {'Authorization': f'Bearer {id_token}'}
    url_start = 'https://firestore.googleapis.com/v1/projects/minitb-rs/databases/(default)/documents'
    out_docs = {}
    for collection in collections:
        out_docs[collection] = {}
        for name in names:
            url = f"{url_start}/{collection}/{name}"
            doc = requests.get(url, headers=headers)
            if name == 'Admin':
                name = 'Reference'
            out_docs[collection][name] = {}
            fields = doc.json()['fields']
            for key, value in fields.items():
                if key == 'name':
                    continue
                try:
                    out_docs[collection][name][key] = int(value['integerValue'])
                except KeyError:
                    try:
                        out_docs[collection][name][key] = value['stringValue']
                    except KeyError:
                        continue
    out_file = open(out_file_name, "w")
    out_file.write(yaml.dump(out_docs))
    out_file.close()


if __name__ == '__main__':
    download_minitb()
