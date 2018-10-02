Yet another URL Shortener

## Workflow Instructions

clone repo

```sh

git clone git@github.com:Lusitaniae/Golang-Url-Shortener.git

cd Golang-Url-Shortener/GoLinkShortener/

```

compile golang for linux

```sh
env GOOS=linux GOARCH=386 go build
```

build docker image

```sh
docker build -t shortner-backend --file ../Dockerfile.backend ..
```

tag docker image

```sh
docker tag shortner-backend lusotycoon/shortner-backend
```

update docker image

```sh
docker push lusotycoon/shortner-backend
```

start kubernetes database

```sh
kubectl create -f ../redis.yaml
```

start kubernetes application

```sh
kubectl create -f ../application.yaml
```