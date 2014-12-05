module.exports = (grunt) ->

  jsDependencies = [
    '/lib/es5-shim/es5-shim.js'
    '/hacks/h5shivhack.js'
    '/lib/modernizr/modernizr.js'
    '/lib/jquery/jquery.js'
    '/lib/angular/angular.js'
    '/lib/angular-route/angular-route.js'
  ]

  devCopySources = [
    'fonts/*'
    'hacks/*'
    'img/*'
    'lib/**/*'
    'views/**/*'
    'templates/**/*'
    'backend-mock/**/*.json'
  ]

  lessSources = 'styles/**/*.less'
  coffeeSources = 'scripts/**/*.coffee'

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
          sourceMapBasepath: '.tmp/styles'
        files:
          ".tmp/styles/addressbook.css": ".tmp/styles/addressbook.less"
      dist:
        options:
          compress: true
        files:
          "dist/styles/addressbook.min.css": "app/styles/addressbook.less"

    coffee:
      dev:
        options:
          sourceMap: true
        expand: true
        cwd: '.tmp/scripts'
        src: '**/*.coffee'
        dest: '.tmp/scripts'
        ext: '.js'
      dist:
        files:
          'main.js': ['app/scripts/main.coffee','app/scripts/**/*.coffee']

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
          'dist/scripts/app.min.js': jsDependencies.map((dep) -> "app/#{dep}").concat ['main.js']

    watch:
      less:
        files: "app/#{lessSources}"
        tasks: ['copy:dev_less', 'less:dev']
      coffee:
        files: "app/#{coffeeSources}"
        tasks: ['copy:dev_coffee', 'coffee:dev']
      copy:
        files: devCopySources.map (src) -> "app/#{src}"
        tasks: ['copy:dev']
      htmlbuild:
        files: ['app/index.html']
        tasks: ['htmlbuild:dev']
      options:
        livereload: true

    htmlbuild:
      dev:
        src: 'app/index.html'
        dest: '.tmp/index.html'
        options:
          relative: true
          scripts:
            main: jsDependencies.map((dep) -> ".tmp/#{dep}").concat ['.tmp/scripts/main.js', '.tmp/scripts/**/*.js']
          styles:
            main: '.tmp/styles/addressbook.css'
      dist:
        src: 'app/index.html'
        dest: 'dist'
        options:
          relative: true
          scripts:
            main: 'dist/scripts/app.min.js'
          styles:
            main: 'dist/styles/addressbook.min.css'

    copy:
      dev:
        expand: true
        cwd: 'app'
        src: devCopySources
        dest: '.tmp'
        rename: (dest, src) -> "#{dest}/#{src.replace(/(backend-mock\/|\.json$)/g, '')}"
      dev_less:
        expand: true
        cwd: 'app'
        src: lessSources
        dest: '.tmp'
      dev_coffee:
        expand: true
        cwd: 'app'
        src: coffeeSources
        dest: '.tmp'
      dist:
        expand: true
        cwd: 'app'
        src: ['fonts/*', 'views/**/*', 'templates/**/*']
        dest: 'dist'

    clean:
      dist: ['main.js']
      all: ["dist", ".tmp"]

    shell:
      git_tag:
        command: ->
          "git tag -a CI-#{process.env.BUILD_ID} -m 'Successfully built by CI.'"
      git_push_tag:
        command: ->
          "git push --tags"

    compress:
      dist:
        options:
          archive: 'wild_sofea.zip'
        files: [
          expand: true
          src: ['**/*']
          cwd: 'dist/'
        ]
    imagemin:
      dist:
        options:
          optimizationLevel: 3
        files: [
          expand: true
          cwd: "app/"
          src: ["img/*"]
          dest: "dist"
        ]

    connect:
      dev:
        options:
          hostname: '*'
          port: 9997
          base: '.tmp'
          livereload: true
      dist:
        options:
          hostname: '*'
          port: 9996
          base: 'dist'
          keepalive: true

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
  grunt.loadNpmTasks 'grunt-contrib-compress'
  grunt.loadNpmTasks 'grunt-contrib-imagemin'

  grunt.registerTask 'copy_dev', ['copy:dev', 'copy:dev_less', 'copy:dev_coffee']
  grunt.registerTask 'compile_dev', ['coffee:dev', 'less:dev', 'htmlbuild:dev']
  grunt.registerTask 'compile_dist', ['coffee:dist', 'less:dist', 'uglify', 'htmlbuild:dist', 'clean:dist']
  grunt.registerTask 'dev', ['bower', 'copy_dev', 'compile_dev', 'connect:dev', 'watch']
  grunt.registerTask 'test', ['karma:dev']
  grunt.registerTask 'dist', ['bower', 'compile_dist', 'copy:dist', 'imagemin', 'compress:dist']
  grunt.registerTask 'ci', ['dist','karma:ci','shell:git_tag','shell:git_push_tag']
  grunt.registerTask 'local-ci', ['bower', 'karma:ci']