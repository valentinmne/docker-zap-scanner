

# Docker Zap Scanner



<center>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</center>


## What for ?

Scan a list of URLS with Zap Scan


### Prerequisite


 - You need to have Docker installed

### Clone this repo

```
git clone "https://github.com/valentinmne/docker-zap-scanner.git"
cd docker-zap-git
```

## Execute the shell script :

```
./scanner.sh [http or https] [file to use] [path to save your scan]
```


### Arguments:  

Arg Position | Usages | Value by default | In Terminal
:-|:-|:-|:-|
1 | choose http or https scan for the url provided | https | ```sudo ./command.sh http ```
2 | Select the textfile where url are stored | urls.txt | ```sudo ./command.sh http url2.txt ```
3 | Specify the path to save your scan | /var/www/html  | ```sudo ./command.sh http url2.txt /docker/scanner/```


### Currently implemented

- Args handeling
- Scan a list of url stored in a file

## Sources : 

- https://www.zaproxy.org/docs/docker/about/



## Contributors

- valentinmne : valentin.moine@protonmail.com
