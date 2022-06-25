#!/usr/bin/env python3

import json
import os
import requests
import sys
from datetime import date


def get_daily_standings_from_api():
    url = 'https://data.nba.net/10s/prod/v1/current/standings_conference.json'
    headers = {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET"
    }
    resp = requests.get(url, headers=headers)
    if resp.status_code != 200:
        print(resp.json())
        sys.exit('Could not retrieve NBA standings')
    json_resp = resp.json()
    east = json_resp['league']['standard']['conference']['east']
    west = json_resp['league']['standard']['conference']['west']
    standings = {}
    for i in range(15):
        standings[east[i]['teamSitesOnly']['teamTricode']] = {'integerValue': f'{i+1}'}
        standings[west[i]['teamSitesOnly']['teamTricode']] = {'integerValue': f'{i+1}'}
    return standings


def get_di_token():
    pwd = os.getenv('PASSWORD')
    if pwd is None:
        pwd = ""
    auth_url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDiXzh_G3clIgnzU_k5tSPmSSOFL2L8-IM'
    auth_data = f'{{"email":"torneobasce@gmail.com","password":"{pwd}","returnSecureToken":true}}'
    auth_headers = {'Content-Type': 'application/json'}
    r = requests.post(auth_url, data=auth_data, headers=auth_headers)
    if r.status_code != 200:
        print(r.json())
        sys.exit('Could not get id token for Firebase DB')
    return (r.json())['idToken']


def push_standings_to_db(standings):
    document = {'fields': standings}
    id_token = get_di_token()
    headers = {'Authorization': f'Bearer {id_token}'}
    today = date.today()
    doc_name = today.strftime("%Y-%m-%d")
    url = f'https://firestore.googleapis.com/v1/projects/minitb-rs/databases/(default)/documents/minitb-daily/{doc_name}'
    resp = requests.patch(url, data=json.dumps(document), headers=headers)
    if resp.status_code != 200:
        print(resp.json())
        sys.exit('Could not create daily standings document')
    print(resp.json())
    url = f'https://firestore.googleapis.com/v1/projects/minitb-rs/databases/(default)/documents/predictions/Admin'
    document['fields']['name'] = {'stringValue': 'Admin'}
    resp = requests.patch(url, data=json.dumps(document), headers=headers)
    if resp.status_code != 200:
        print(resp.json())
        sys.exit('Could not update standings document')
    print(resp.json())


def daily_minitb():
    standings = get_daily_standings_from_api()
    push_standings_to_db(standings)


if __name__ == '__main__':
    daily_minitb()
