# Build a simple Docker Image using Dockerfile

## Manual Steps

open Docker1 folder
cd Docker1
open figlet file

- pull an ubuntu image

```bash
docker pull ubuntu
```


- run the container interactively

```bash
docker run -it ubuntu
```


- update packages in the container

```bash
apt-get update -y
```

- install figlet app

```bash
apt-get install figlet
```

- run the app

```bash
figlet Merhaba B 224 aws-devops! 
```


## Do with Dockerfile

- create the Dockerfile with nano or your favorite editor

```Dockerfile
FROM ubuntu
RUN apt-get update
RUN apt-get install figlet
ENTRYPOINT figlet Merhaba B149 aws-devops
# CMD can also be used here
```
- build the image

```bash
docker build -t fig-app .
```

- view the images

```bash
docker images
```

- run the image as a container

```bash
docker run fig-app
```
 __  __           _           _             ____    ____  ____  _  _   
|  \/  | ___ _ __| |__   __ _| |__   __ _  | __ )  |___ \|___ \| || |  
| |\/| |/ _ \ '__| '_ \ / _` | '_ \ / _` | |  _ \    __) | __) | || |_ 
| |  | |  __/ |  | | | | (_| | |_) | (_| | | |_) |  / __/ / __/|__   _|
|_|  |_|\___|_|  |_| |_|\__,_|_.__/ \__,_| |____/  |_____|_____|  |_|  
                                                                       
                              _                           _ 
  __ ___      _____        __| | _____   _____  _ __  ___| |
 / _` \ \ /\ / / __|_____ / _` |/ _ \ \ / / _ \| '_ \/ __| |
| (_| |\ V  V /\__ \_____| (_| |  __/\ V / (_) | |_) \__ \_|
 \__,_| \_/\_/ |___/      \__,_|\___| \_/ \___/| .__/|___(_)
                                               |_|          

## Pass arguments to container at runtime using ENTRYPOINT exec mode

- modify the Dockerfile

```Dockerfile
FROM ubuntu
RUN apt-get update
RUN apt-get install figlet
ENTRYPOINT ["figlet", "Merhaba"]
```

- build the image

```bash
docker build -t fig-app2 .
```

- view the images

```bash
docker images
```

- run the image as a container, this time passing an argument

```bash
docker run fig-app2 Dockerseverler!
```

__  __           _           _           
|  \/  | ___ _ __| |__   __ _| |__   __ _ 
| |\/| |/ _ \ '__| '_ \ / _` | '_ \ / _` |
| |  | |  __/ |  | | | | (_| | |_) | (_| |
|_|  |_|\___|_|  |_| |_|\__,_|_.__/ \__,_|
                                          
 ____             _                                     _           
|  _ \  ___   ___| | _____ _ __ ___  _____   _____ _ __| | ___ _ __ 
| | | |/ _ \ / __| |/ / _ \ '__/ __|/ _ \ \ / / _ \ '__| |/ _ \ '__|
| |_| | (_) | (__|   <  __/ |  \__ \  __/\ V /  __/ |  | |  __/ |   
|____/ \___/ \___|_|\_\___|_|  |___/\___| \_/ \___|_|  |_|\___|_|   


# Dockerize HTML page and a Node App

Docker Hub is a registry, collection of repos
On Docker Hub you can have public or private repositories for your applications
Repository is having versions of an application, collection of related images

## Convert your index.html simple web page to a Docker Image
open folder
mkdir devops
cd devops
- create index.html file

```html
<h1>Welcome to our web page</h1>

<h2>DevOps Batch 149</h2>
```

- create a Dockerfile

```Dockerfile
FROM nginx:1.22-alpine
COPY . /usr/share/nginx/html

```
- build the image

```bash
docker build -t mysite .
```
- run the image as container

```bash
docker run -d -p 80:80 mysite:latest