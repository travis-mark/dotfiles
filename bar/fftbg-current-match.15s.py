#!/usr/bin/python

import urllib2
import json

matches = [[u'red', u'blue'], [u'green', u'yellow'], [u'white', u'black'], [u'purple', u'brown'], [0, 1], [2, 3], [4, 5], [6, u'champ']]
contents = urllib2.urlopen("https://fftbg.com/api/tournaments?limit=1").read()
parsed = json.loads(contents)
winners = parsed[0]['Winners']
match_number = len(winners) 
if match_number < len(matches):
    match = matches[match_number]
    left = match[0] if type(match[0]) == type(u'') else winners[match[0]]
    right = match[1] if type(match[1]) == type(u'') else winners[match[1]]
    print(left + ' vs. ' + right)
else:
    print('NO CURRENT MATCH')
    print('?fight')