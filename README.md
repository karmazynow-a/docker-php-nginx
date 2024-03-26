# Docker PHP-FPM 8.0 & Nginx 1.20 on AlmaLinux 9

based on repository: https://github.com/piotrmoszkowicz/docker-php-nginx

This image can be pulled from Docker Hub under the name [aporeba/alma9-docker-php-nginx](https://hub.docker.com/r/aporeba/alma9-docker-php-nginx).

## Usage

Start the Docker container:

    docker run -p 80:8080 piotrmoszkowicz/centos-docker-php-nginx

See the PHP info on http://localhost, or the static html page on http://localhost/test.html

Or mount your own code to be served by PHP-FPM & Nginx

    docker run -p 80:8080 -v ~/my-codebase:/var/www/html piotrmoszkowicz/centos-docker-php-nginx


## Build and push a tag (notes to myself)
```
# login
docker login -u aporeba

# build and tag an image
IMAGE=aporeba/alma9-docker-php-nginx
VERSION=1.0
docker build -t ${IMAGE}:${VERSION} .
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

# check if the image was build
docker image ls

# push
docker push aporeba/alma9-docker-php-nginx:latest
```
