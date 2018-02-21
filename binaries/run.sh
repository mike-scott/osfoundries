#!/bin/bash
token=""

alias jobserv-curl='curl -H '\''OSF-TOKEN: $token'\'' '
filename=blog-post-update-

curl-it(){
    echo "getting notes for $1, $2, $3 ..."
    echo $1 >> ../src/content/blog/$filename$3.md
    jobserv-curl https://api.foundries.io/releases/$2/$3/ | ./mp2md.py >> ../src/content/blog/$filename$3.md
}

highlight-it(){
    echo "getting summaries $1 $2 ..."
    echo "# Summary" >> ../src/content/blog/$filename$2.md
    echo "" >> ../src/content/blog/$filename$2.md
    echo "## Zephyr microPlatform changes for $2" >> ../src/content/blog/$filename$2.md
    echo "" >> ../src/content/blog/$filename$2.md
    jobserv-curl https://api.foundries.io/releases/zmp/$2/ | ./mp2md-highlights.py >> ../src/content/blog/$filename$2.md
    echo "" >> ../src/content/blog/$filename$2.md
    echo "## Linux microPlatform changes for $2" >> ../src/content/blog/$filename$2.md
    echo "" >> ../src/content/blog/$filename$2.md
    jobserv-curl https://api.foundries.io/releases/lmp/$2/ | ./mp2md-highlights.py >> ../src/content/blog/$filename$2.md
    echo "<!--more-->" >> ../src/content/blog/$filename$2.md
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
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.1
header $var '2017-11-08'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.2
header $var '2017-11-16'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.3
header $var '2017-12-07'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.4
header $var '2017-12-13'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.5
header $var '2018-01-04'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.6
header $var '2018-01-10'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.7
header $var '2018-01-25'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.8
header $var '2018-02-02'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

var=0.9
header $var '2018-02-21'
highlight-it '# Highlights' $var
curl-it '# Zephyr microPlatform' zmp $var
curl-it '# Linux microPlatform' lmp $var

