#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTRED='\033[1;31m'

if [ "$1" == "http" ]
then
baseurl="http://"
else
baseurl="https://"
fi

if [ "$2" == "" ]
then
filename='urls.txt'
else
filename="$2"
fi


if [ "$2" == "" ]
then
delivery='/var/www/html'
else
delivery="$3"
fi


while read line; do
# reading each line
echo -e "${GREEN}Scanning $line${NOCOLOR}"
echo -e "${YELLOW}Creating directory : $line/$(date +%Y-%m-%d)${NOCOLOR}"
echo ""
mkdir -p $delivery$line/$(date +%Y-%m-%d)
cd $delivery$line/$(date +%Y-%m-%d)
chmod 777 -R $delivery
docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-full-scan.py -m 10 -t $baseurl$line  -g generated_file.conf -r shiny_report.html
echo ""
echo -e "${YELLOW}The report is located at $(pwd)${NOCOLOR}"
cd ../..
echo -e "${LIGHTGREEN}Scan of $baseurl$line Complete.${NOCOLOR}"

user_interrupt(){
        echo -e "\n\nKeyboard Interrupt detected."
        sleep 2
        echo -e "${LIGHTRED}You pressed Ctrl + C, your scan could be not complete or corrupted${NOCOLOR}"
}

trap user_interrupt SIGINT
echo ""
done < $filename
