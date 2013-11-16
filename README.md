# Bitcamp

The main website for the University of Maryland's February hacking event.

Bitcamp is organized and put together by
* [Terrapin Hackers](http://terrapinhackers.com/)
* [Startup Shell](http://startupshell.org/)


## Dependencies

* [NodeJS](http://nodejs.org/)
* [Git](http://git-scm.com/)
* [CoffeeScript](http://coffeescript.org/)
* [SASS](http://sass-lang.com/)
* [Jade-lang](http://jade-lang.com/)
* [ExpressJS](http://expressjs.com/)
* [GruntJS](http://gruntjs.com/)
* [Bower](http://twitter.github.com/bower/)


## Installation

1. download -> install **git**
  [http://git-scm.com/download/](http://git-scm.com/download/)

2. download -> install **NodeJS** and **NPM**
  [http://nodejs.org/](http://nodejs.org/)

3. install **global NodeJS dependencies**
  ```bash sudo npm install -g coffee-script grunt-cli bower```
4. install **back-end dependencies**
  ```bash npm install```
5. install **front-end dependencies**
  ```bash bower install```
6. install **SASS** and **Compass**
  ```bash gem install sass compass```


## Common Tasks:

### Build entire site
```bash grunt```

### Run back-end server
```bash node server.js```

### Auto-build site and live-reload browser
```bash grunt watch```

