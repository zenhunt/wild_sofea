module.exports = function(grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        bower: {
            install: {
                options: {
                    targetDir: 'app/lib'
                }
            }
        },
        less: {
            dev: {
                options: {
                    sourceMap: true,
                    sourceMapRootpath: '../../'
                },
                files: {
                    ".tmp/css/addressbook.css": "app/less/addressbook.less"
                }
            },
            dist: {
                options: {
                    compress: true
                },
                files: {
                    "dist/css/addressbook.min.css": "app/less/addressbook.less"
                }
            }
        },
        coffee: {
            dev: {
                options: {
                    sourceMap: true
                },
                expand: true,
                cwd: 'app/scripts',
                src: '**/*.coffee',
                dest: '.tmp/js',
                ext: '.js'
            },
            dist: {
                files: {
                    '.tmp/js/main.js': 'app/scripts/**/*.coffee'
                }
            }
        },
        karma: {
            options: {
                configFile: 'karma.conf.js'
            },
            dev: {},
            dist: {
                singleRun: true,
                autoWatch: false,
                browsers: ['PhantomJS']
            },
            ci: {
                singleRun: true,
                autoWatch: false,
                reporters: ['junit'],
                junitReporter: {
                    outputFile: 'test-results.xml'
                },
                browsers: ['PhantomJS']
            }
        },
        uglify: {
            options: {
                banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
                    '<%= grunt.template.today("yyyy-mm-dd") %> */'
            },
            dist: {
                files: {
                    'dist/js/app.min.js': [
                        'app/lib/angular/angular.js',
                        'app/hacks/h5shivhack.js', // must be loaded up front of modernizr
                        'app/lib/modernizr/modernizr.js',
                        '.tmp/js/main.js'
                    ]
                }
            }
        },
        watch: {
            less: {
                files: ['app/less/**/*.less'],
                tasks: ['less:dev']
            },
            coffee: {
                files: ['app/scripts/**/*.coffee'],
                tasks: ['coffee:dev']
            }
        },
        htmlbuild: {
            dist: {
                src: 'app/app.html',
                dest: 'dist',
                options: {
                    relative:true,
                    scripts: {
                        main: 'dist/js/app.min.js'
                    },
                    styles: {
                        main: 'dist/css/addressbook.min.css'
                    }
                }
            }
        },
        copy: {
            dev: {
                expand: true,
                cwd: 'app',
                src: ['fonts/*', 'img/*'],
                dest: '.tmp'
            },
            dist: {
                expand: true,
                cwd: 'app',
                src: ['fonts/*', 'img/*'],
                dest: 'dist'
            }
        },
        clean: ["dist", ".tmp"],
        shell: {
            git_tag: {
                command: function() {
                    return "git tag -a CI-" + process.env.BUILD_ID + " -m 'Successfully built by CI.'"
                }
            },
            git_push_tag: {
                command: function() {
                    return "git push --tags"
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-bower-task');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-karma');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-html-build');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-shell');

    grunt.registerTask('dev', ['bower', 'copy:dev', 'coffee:dev', 'less:dev', 'watch']);
    grunt.registerTask('test', ['karma:dev']);
    grunt.registerTask('dist', ['bower', 'karma:dist', 'less:dist', 'coffee:dist', 'uglify:dist', 'htmlbuild:dist', 'copy:dist']);
    grunt.registerTask('ci', ['bower', 'karma:ci', 'less:dist', 'coffee:dist', 'uglify:dist', 'htmlbuild:dist', 'copy:dist', 'shell:git_tag', 'shell:git_push_tag']);

};