#! /usr/bin/python

# Simple script for reading in microPlatform JSON and converting to markdown

import sys,json
from pprint import pprint

data = json.load(sys.stdin)

try:
    summary = data['data']['release']['notes']['summary']
    print summary

except KeyError:
    print "No highlight"
