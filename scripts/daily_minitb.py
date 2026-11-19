#!/usr/bin/env python3

import json
import os
import io
import requests
import pandas as pd
import sys
from datetime import date
from nba_api.stats.endpoints import leaguestandings

tricode_map = {
    'Celtics': 'BOS',
    'Jazz': 'UTA',
    'Bulls': 'CHI',
    'Warriors': 'GSW',
    'Pelicans': 'NOP',
    'Wizards': 'WAS',
    'Pistons': 'DET',
    'Timberwolves': 'MIN',
    'Raptors': 'TOR',
    'Trail Blazers': 'POR',
    'Hornets': 'CHA',
    'Suns': 'PHX',
    'Grizzlies': 'MEM',
    'Hawks': 'ATL',
    'Cavaliers': 'CLE',
    'Mavericks': 'DAL',
    'Magic': 'ORL',
    'Thunder': 'OKC',
    'Kings': 'SAC',
    'Pacers': 'IND',
    'Heat': 'MIA',
    'Lakers': 'LAL',
    '76ers': 'PHI',
    'Nuggets': 'DEN',
    'Rockets': 'HOU',
    'Knicks': 'NYK',
    'Spurs': 'SAS',
    'Nets': 'BKN',
    'Clippers': 'LAC',
    'Bucks': 'MIL'
}


def get_proxy_list():
    resp = requests.get('https://free-proxy-list.net/')
    tables = pd.read_html(io.StringIO(resp.text))
    df = next(t for t in tables if 'Https' in t.columns.str.replace(' ', ''))
    df.columns = df.columns.str.replace(' ', '')
    df = df[df['Country'] != 'United States']
    return df[['IP:Port', 'Country']]


def fetch_league_standings(proxy=None):
    return leaguestandings.LeagueStandings(proxy=proxy, timeout=30).get_dict()


def parse_standings(d):
    standings = {}
    for team in d['resultSets'][0]['rowSet']:
        standings[tricode_map[team[4]]] = {'integerValue': f'{team[7]}'}
        standings[f'{tricode_map[team[4]]}-wins'] = {'stringValue': f'{team[16]}'}
    return standings


def get_daily_standings_from_api_2():
    try:
        return parse_standings(fetch_league_standings()), 'direct'
    except Exception as e:
        print('Direct request failed:', repr(e))

    for _, row in get_proxy_list().head(100).iterrows():
        proxy = row['IP:Port']
        country = row['Country']
        print('Trying Proxy:', proxy, ', Country:', country)
        try:
            return parse_standings(fetch_league_standings(proxy)), country
        except Exception as e:
            print('Proxy failed:', repr(e))

    sys.exit('Could not retrieve NBA standings directly or via any proxy')


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
        standings[east[i]['teamSitesOnly']['teamTricode']] = {'integerValue': f'{i + 1}'}
        standings[west[i]['teamSitesOnly']['teamTricode']] = {'integerValue': f'{i + 1}'}
    return standings


def get_di_token():
    pwd = os.getenv('PASSWORD')
    if pwd is None:
        pwd = ""
    auth_url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDiXzh_G3clIgnzU_k5tSPmSSOFL2L8-IM'
    auth_data = f'{{"email":"firebase@matluca.com","password":"{pwd}","returnSecureToken":true}}'
    auth_headers = {'Content-Type': 'application/json'}
    r = requests.post(auth_url, data=auth_data, headers=auth_headers)
    if r.status_code != 200:
        print(r.json())
        sys.exit('Could not get id token for Firebase DB')
    return (r.json())['idToken']


def push_standings_to_db(standings, proxy_country):
    document = {'fields': standings}
    id_token = get_di_token()
    headers = {'Authorization': f'Bearer {id_token}'}
    today = date.today()
    today_string = today.strftime("%Y-%m-%d")
    url = f'https://firestore.googleapis.com/v1/projects/minitb-rs/databases/(default)/documents/minitb-daily/{today_string}'
    resp = requests.patch(url, data=json.dumps(document), headers=headers)
    if resp.status_code != 200:
        print(resp.json())
        sys.exit('Could not create daily standings document')
    print(resp.json())
    url = f'https://firestore.googleapis.com/v1/projects/minitb-rs/databases/(default)/documents/predictions/Admin'
    document['fields']['name'] = {'stringValue': 'Admin'}
    document['fields']['date'] = {'stringValue': today_string}
    document['fields']['proxy_country'] = {'stringValue': proxy_country}
    resp = requests.patch(url, data=json.dumps(document), headers=headers)
    if resp.status_code != 200:
        print(resp.json())
        sys.exit('Could not update standings document')
    print(resp.json())


def daily_minitb():
    standings, proxy_country = get_daily_standings_from_api_2()
    push_standings_to_db(standings, proxy_country)


if __name__ == '__main__':
    daily_minitb()
