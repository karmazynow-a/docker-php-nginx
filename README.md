# Docker PHP-FPM 8.0 & Nginx 1.20 on CentOS 7
Example PHP-FPM 8.0 & Nginx 1.20 setup for Docker, build on [CentOS 7](https://wiki.centos.org/FAQ/CentOS7).

Repository: https://github.com/piotrmoszkowicz/docker-php-nginx

It is based on Tim de Pater's work - repository: https://github.com/TrafeX/docker-php-nginx
Huge thanks to Tim for his work!

* Uses PHP 8.0 for better performance, lower CPU usage & memory footprint
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's on-demand PM)
* The servers Nginx, PHP-FPM and supervisord run under a non-privileged user (nobody) to make it more secure
* The logs of all the services are redirected to the output of the Docker container (visible with `docker logs -f <container name>`)
* Follows the KISS principle (Keep It Simple, Stupid) to make it easy to understand and adjust the image to your needs


[![Docker Pulls](https://img.shields.io/docker/pulls/piotrmoszkowicz/centos-docker-php-nginx.svg)](https://hub.docker.com/u/piotrmoszkowicz/centos-docker-php-nginx)
![nginx 1.18.0](https://img.shields.io/badge/nginx-1.20-brightgreen.svg)
![php 8.0](https://img.shields.io/badge/php-8.0-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

This image can be pulled from Docker Hub under the name [piotrmoszkowicz/centos-docker-php-nginx](https://hub.docker.com/u/piotrmoszkowicz/centos-docker-php-nginx).

## Usage

Start the Docker container:

    docker run -p 80:8080 piotrmoszkowicz/centos-docker-php-nginx

See the PHP info on http://localhost, or the static html page on http://localhost/test.html

Or mount your own code to be served by PHP-FPM & Nginx

    docker run -p 80:8080 -v ~/my-codebase:/var/www/html piotrmoszkowicz/centos-docker-php-nginx
