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
                    "app/css/addressbook.css": "app/less/addressbook.less"
                }
            },
            dist: {
                options: {
                    compress: true
                },
                files: {
                    "dist/css/addressbook.css": "app/less/addressbook.less"
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
                dest: 'app/js',
                ext: '.js'
            },
            dist: {
                files: {
                    'dist/js/main.js': 'app/scripts/**/*.coffee'
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
        clean: ["app/css", "app/js", "dist"]
    });

    grunt.loadNpmTasks('grunt-bower-task');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.registerTask('deps', ['bower']);
    grunt.registerTask('test', []);
    grunt.registerTask('dist', ['less:dist']);

};