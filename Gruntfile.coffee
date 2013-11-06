module.exports = (grunt) ->

  jsDependencies = [
    '/hacks/h5shivhack.js'
    '/lib/modernizr/modernizr.js'
    '/lib/angular/angular.js'
    '/lib/angular-route/angular-route.js'
  ]

  devCopySources = [
    'fonts/*'
    'img/*'
    'lib/**/*'
    'views/**/*'
    'backend-mock/**/*.json',
    'less/**/*',
    'scripts/**/*.coffee'
  ]

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    bower:
      install:
        options:
          targetDir: 'app/lib'

    less:
      dev:
        options:
          sourceMap: true
          sourceMapRootpath: '../'
          sourceMapBasepath: '.tmp/'
        files:
          ".tmp/css/addressbook.css": ".tmp/less/addressbook.less"
      dist:
        options:
          compress: true
        files:
          "dist/css/addressbook.min.css": "app/less/addressbook.less"

    coffee:
      dev:
        options:
          sourceMap: true
        expand: true
        cwd: '.tmp/scripts'
        src: '**/*.coffee'
        dest: '.tmp/js'
        ext: '.js'
      dist:
        files:
          '.tmp/js/main.js': 'app/scripts/**/*.coffee'

    karma:
      options:
        configFile: 'karma.conf.js'
      dev: {}
      dist:
        singleRun: true
        autoWatch: false
        browsers: ['PhantomJS']
      ci:
        singleRun: true
        autoWatch: false
        reporters: ['junit']
        junitReporter:
          outputFile: 'test-results.xml'
        browsers: ['PhantomJS']

    uglify:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %> */'
      dist:
        files:
          'dist/js/app.min.js': jsDependencies.map((dep) -> "app/#{dep}").concat ['.tmp/js/main.js']

    watch:
      less:
        files: ['.tmp/less/**/*.less']
        tasks: ['less:dev']
      coffee:
        files: ['.tmp/scripts/**/*.coffee']
        tasks: ['coffee:dev']
#      copy: TODO: break down into smaller tasks. this takes too long and also triggers coffee + less
#        files: devCopySources.map (src) -> "app/#{src}"
#        tasks: ['copy:dev']
      htmlbuild:
        files: ['app/app.html']
        tasks: ['htmlbuild:dev']
      options:
        livereload: true

    htmlbuild:
      dev:
        src: 'app/app.html'
        dest: '.tmp/app.html'
        options:
          relative: true
          scripts:
            main: jsDependencies.map((dep) -> ".tmp/#{dep}").concat ['.tmp/js/main.js', '.tmp/js/**/*.js']
          styles:
            main: '.tmp/css/addressbook.css'
      dist:
        src: 'app/app.html'
        dest: 'dist'
        options:
          relative: true
          scripts:
            main: 'dist/js/app.min.js'
          styles:
            main: 'dist/css/addressbook.min.css'

    copy:
      dev:
        expand: true
        cwd: 'app'
        src: devCopySources
        dest: '.tmp'
        rename: (dest, src) -> "#{dest}/#{src.replace(/(backend-mock\/|\.json$)/g, '')}"
      dist:
        expand: true
        cwd: 'app'
        src: ['fonts/*', 'img/*', 'views/**/*']
        dest: 'dist'

    clean: ["dist", ".tmp"]

    shell:
      git_tag:
        command: ->
          "git tag -a CI-#{process.env.BUILD_ID} -m 'Successfully built by CI.'"
      git_push_tag:
        command: ->
          "git push --tags"

    connect:
      dev:
        options:
          port: 9997
          base: '.tmp'
          livereload: true

  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-html-build'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.registerTask 'dev', ['bower', 'copy:dev', 'coffee:dev', 'less:dev', 'htmlbuild:dev', 'connect:dev', 'watch']
  grunt.registerTask 'test', ['karma:dev']
  grunt.registerTask 'dist', ['bower', 'karma:dist', 'less:dist', 'coffee:dist', 'uglify:dist', 'htmlbuild:dist', 'copy:dist']
  grunt.registerTask 'ci', ['bower','karma:ci','less:dist','coffee:dist','uglify:dist','htmlbuild:dist','copy:dist','shell:git_tag','shell:git_push_tag']