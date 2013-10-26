wild_sofea
==========

S.O.F.E.A. in the wild - A demo for a single page app using html5, lesscss and angularjs...

## How to build this project

Make shure you have installed [node.js](http://nodejs.org) and [grunt.js](http://gruntjs.com/).
Install grunt.jd:

    `npm install -g grunt-cli`

Now you can install all project dependencies. Run the following command in the project root:

    `npm install`

Now you can execute the configured grunt tasks. The most important tasks are:

* `grunt dev` - runs all tasks which are needed to initialize the development mode and then start watching for changes.
* `grunt test` - runs all your tests.
* `grunt dist` - compiles down your HTML, LESS and CoffeeScript to the folder dist for production mode.
* `grunt clean` - removes all compiled files