#!/bin/bash
token=""

alias jobserv-curl='curl -H '\''OSF-TOKEN: $token'\'' '
filename=blog-post-update-

curlit(){
    echo $1 >> ../src/content/blog/$filename$3.md
    jobserv-curl https://api.foundries.io/releases/$2/$3/ | ./mp2md.py >> ../src/content/blog/$filename$3.md
}

header(){
cat > ../src/content/blog/$filename$1.md <<EOL
+++
title = "microPlatform update $1"
date = "$2"
tags = ["linux", "zephyr", "update", "cve", "bugs"]
categories = ["updates", "microPlatform"]
banner = "img/banners/update.png"
+++

EOL
}

var=17.10.1
header $var '2017-10-13'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var

var=0.2
header $var '2017-11-16'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var

var=0.3
header $var '2017-12-07'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var

var=0.4
header $var '2017-12-13'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var

var=0.5
header $var '2018-01-04'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var

var=0.6
header $var '2018-01-10'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var

var=0.7
header $var '2018-01-25'
curlit '# Zephyr microPlatform' zmp $var
curlit '# Linux microPlatform' lmp $var
