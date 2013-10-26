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
                    paths: ["app/less"],
                    sourceMap: true
                    //sourceMapFilename: 'addressbook.css.map'
                },
                files: {
                    "app/css/addressbook.css": "app/less/addressbook.less"
                }
            },
            dist: {
                options: {
                    paths: ["app/less"],
                    compress: true
                },
                files: {
                    "dist/css/addressbook.css": "app/less/addressbook.less"
                }
            }
        },
        watch: {
            files: ['app/less/**/*.less'],
            tasks: ['less:dev']
        },
        clean: ["app/css", "app/js", "dist"]
    });

    grunt.loadNpmTasks('grunt-bower-task');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-clean');

    grunt.registerTask('deps', ['bower']);
    grunt.registerTask('test', []);
    grunt.registerTask('dist', ['less:dist']);

};