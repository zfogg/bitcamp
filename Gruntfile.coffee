module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    copy:
      bootstrap:
        files: [
          expand: true
          src: ["components/bootstrap/dist/css/*bootstrap*"]
          dest: "public/css/"
          filter: "isFile"
        ]
      sourcemaps:
        files: [
          expand: true
          flatten: true
          src: ['components/**/*.map']
          dest: 'public/js/'
          filter: 'isFile'
        ]
      public_static:
        files: [
          expand: true
          cwd: "src/public"
          src: ["*", "!**/*"]
          dest: "public/"
          filter: "isFile"
        ]

    jade:
      compile:
        options:
          pretty: false
          data:
            debug: false
        files:
          "public/index.html":
            ["src/public/jade/index.jade"]

    compass:
      dist:
        options:
          config: "compass.config.rb"

    coffee:
      cpublic:
        options:
          sourceMap: true
          bare: true
        files:
          "public/js/main.js": [
            "src/public/js/main.coffee"
          ]
      cserver:
        options:
          bare: true
        files:
          "server.js": [
            "src/server/server.coffee"
          ]

    uglify:
      plugins:
        files:
          "public/js/plugins.min.js": [
            "components/jquery/jquery.min.js"
            "components/bootstrap/dist/js/bootstrap.js"
            "components/underscore/underscore-min.js"
          ]
      main:
        files:
          "public/js/main.min.js": [
            "public/js/main.js"
          ]

    watch:
      options: livereload: true
      html:
        files: ["src/public/jade/**/*.jade"]
        tasks: ["jade"]
      css:
        files: ["src/public/sass/*.scss", "src/public/sass/*.sass"]
        tasks: ["compass"]
      js:
        files: ["src/public/js/**/*.jade"]
        tasks: ["coffee"]

  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.registerTask "default", [
    "copy"
    "jade"
    "compass"
    "coffee"
    "uglify"
  ]
