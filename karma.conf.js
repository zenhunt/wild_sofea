module.exports = function(config) {
    config.set({
        // base path, that will be used to resolve files and exclude
        basePath: '.',

        frameworks: ['jasmine'],

        // list of files / patterns to load in the browser
        files: [
            'app/lib/jquery/jquery.js',
            'app/lib/angular/angular.js',
            'app/lib/angular-mocks/angular-mocks.js',
            'app/templates/**/*.html',
            'app/scripts/main.coffee',
            'app/scripts/**/*.coffee',
            'test/**/*.coffee'
        ],

        preprocessors: {
            'app/templates/**/*.html': ['ng-html2js'],
            '**/*.coffee': ['coffee']
        },

        ngHtml2JsPreprocessor: {
            // strip this from the file path
            stripPrefix: 'app/',
            // setting this option will create only a single module that contains templates
            // from all the files, so you can load them all with module('foo')
            moduleName: 'templates'
        },

        coffeePreprocessor: {
            // options passed to the coffee compiler
            options: {
//                bare: true,
                sourceMap: true
            },
            transformPath: function(path) {
                return path.replace(/\.js$/, '.coffee');
            }
        },

        // web server port
        // CLI --port 9876
        port: 9876,

        // enable / disable colors in the output (reporters and logs)
        // CLI --colors --no-colors
        colors: true,

        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        // CLI --log-level debug
        logLevel: config.LOG_INFO,

        // enable / disable watching file and executing tests whenever any file changes
        // CLI --auto-watch --no-auto-watch
        autoWatch: true,

        // Start these browsers, currently available:
        // - Chrome
        // - ChromeCanary
        // - Firefox
        // - Opera
        // - Safari (only Mac)
        // - PhantomJS
        // - IE (only Windows)
        // CLI --browsers Chrome,Firefox,Safari
        browsers: ['Chrome'],

        // If browser does not capture in given timeout [ms], kill it
        // CLI --capture-timeout 5000
        captureTimeout: 20000,

        // Auto run tests on start (when browsers are captured) and exit
        // CLI --single-run --no-single-run
        singleRun: false,

        // report which specs are slower than 500ms
        // CLI --report-slower-than 500
        reportSlowerThan: 500,

        plugins: [
            'karma-jasmine',
            'karma-chrome-launcher',
            'karma-phantomjs-launcher',
            'karma-ng-html2js-preprocessor',
            'karma-coffee-preprocessor',
            'karma-junit-reporter'
        ]
    });
};