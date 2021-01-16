#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTRED='\033[1;31m'

scheme="${1:-http}://"
filename="${2:-urls.txt}"
delivery="${3:-./}"

echo "Using scheme=$scheme filename=$filename delivery=$3"

while read line; do
    echo -e "${GREEN}Scanning $line${NOCOLOR}"
    echo -e "${YELLOW}Creating directory : $line/$(date +%Y-%m-%d)${NOCOLOR}"
    echo ""
    mkdir -p $delivery$line/$(date +%Y-%m-%d)
    cd $delivery$line/$(date +%Y-%m-%d)
    chmod 777 -R $delivery
    docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-full-scan.py -m 10 -t $scheme$line  -g generated_file.conf -r shiny_report.html
    echo ""
    echo -e "${YELLOW}The report is located at $(pwd)${NOCOLOR}"
    cd ../..
    echo -e "${LIGHTGREEN}Scan of $scheme$line Complete.${NOCOLOR}"
    echo ""
done < $filename
