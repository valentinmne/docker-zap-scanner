#!/bin/bash
set -eu

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTRED='\033[1;31m'

scheme="${1:-http}"
filename="${2:-urls.txt}"
delivery="${3:-.}"

echo "Using scheme=$scheme filename=$filename delivery=$delivery"

docker run --name zap -d -v $(pwd):/zap/wrk/:rw -l zap --entrypoint sleep owasp/zap2docker-stable infinity
while read entry; do
    currentDirectory="${delivery}/${entry}/$(date +%Y-%m-%d)"
    echo -e "${GREEN}Scanning $entry${NOCOLOR}"
    echo -e "${YELLOW}Creating directory : ${currentDirectory}${NOCOLOR}"
    echo ""
    mkdir -p $currentDirectory

    docker exec -i zap /zap/zap-full-scan.py -m 10 -t $scheme://$entry \
        -g "generated_file.conf" \
        -r "shiny_report.html" || true
    mv -v generated_file.conf shiny_report.html $currentDirectory
    echo ""
    echo -e "${YELLOW}The report is located at $(pwd)${NOCOLOR}"
    echo -e "${LIGHTGREEN}Scan of $scheme$entry Complete.${NOCOLOR}"
    echo ""
done < $filename

echo -e "${LIGHTGREEN}Cleaning up...${NOCOLOR}"

docker stop zap
docker rm zap
