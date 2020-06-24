# php-5.3.29

# Quick reference

# What is PHP?

PHP is a server-side scripting language designed for web development, but which can also be used as a general-purpose programming language. PHP can be added to straight HTML or it can be used with a variety of templating engines and web frameworks. PHP code is usually processed by an interpreter, which is either implemented as a native module on the web-server or as a common gateway interface (CGI).

# How to use this image

```
FROM php:5.3.29-cli
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD [ "php", "./your-script.php" 
```

# Then, run the commands to build and run the Docker image:

```
$ docker build -t my-php-app .
$ docker run -it --rm --name my-running-app my-php-app
```

## Run a single PHP script

For many simple, single file projects, you may find it inconvenient to write a complete Dockerfile. In such cases, you can run a PHP script by using the PHP Docker image directly:

```
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:7.4-cli php your-script.php
```
