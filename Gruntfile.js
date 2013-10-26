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
        uglify: {
            options: {
                banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
                    '<%= grunt.template.today("yyyy-mm-dd") %> */'
            },
            dist: {
                files: {
                    'dist/js/app.min.js': [
                        'app/lib/angular/angular.js',
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
        clean: ["dist", ".tmp"]
    });

    grunt.loadNpmTasks('grunt-bower-task');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-html-build');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.registerTask('dev', ['bower', 'copy:dev', 'coffee:dev', 'less:dev', 'watch']);
    grunt.registerTask('test', ['bower']);
    grunt.registerTask('dist', ['bower', 'less:dist', 'coffee:dist', 'uglify:dist', 'htmlbuild:dist', 'copy:dist']);

};