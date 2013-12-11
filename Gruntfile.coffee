module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    copy:
      public_static:
        files: [
          expand: true
          flatten: true
          src: ["src/public/*"]
          dest: "public/"
          filter: "isFile"
        ]

    jade:
      compile:
        options:
          pretty: false
          data: debug: false
        files:
          "public/index.html":
            ["src/public/jade/index.jade"]

    compass:
      main:
        options:
          config: "compass.config.rb"

    cssmin:
      main:
        files:
          "public/css/main.min.css": [
            "components/bootstrap/dist/css/bootstrap.min.css"
            "build/css/main.css"
          ]

    coffee:
      main:
        options:
          sourceMap: true
        files:
          "build/js/app.js": [
            "src/public/js/controllers.coffee"
            "src/public/js/directives.coffee"
            "src/public/js/filters.coffee"
            "src/public/js/services.coffee"
            "src/public/js/app.coffee"
          ]
      server:
        options:
          bare: true
        files:
          "server.js": ["src/server/server.coffee"]

    concat:
      analytics:
        src: [
          "src/public/js/ga.js"
          "build/js/app.js"
        ]
        dest: "build/js/app.js"
        nonull: true

    uglify:
      main:
        options:
          sourceMappingURL: "/js/main.js.map"
          sourceMapIn: "build/js/app.js.map"
          sourceMap: "public/js/main.js.map"
        files:
          "public/js/main.min.js": [
            "build/js/app.js"
          ]
      vendor:
        files:
          "public/js/vendor.min.js": [
            "components/underscore/underscore-min.js"
            "components/jquery/jquery.min.js"
            "components/angular/angular.min.js"
          ]

    watch:
      html:
        options:
          interrupt: true
        files: ["src/public/jade/**/*.jade"]
        tasks: ["jade"]
      css:
        options:
          interrupt: true
        files: [
          "src/public/css/**/*.scss"
          "src/public/css/**/*.sass"
        ]
        tasks: ["compass", "cssmin"]
      coffee:
        options:
          interrupt: true
        files: ["src/public/js/**/*.coffee"]
        tasks: ["coffee:main", "uglify:main"]
      livereload:
        options:
          livereload: true
        files: [
          "public/css/**/*.css"
          "public/js/**/*.js"
          "public/index.html"
          "server.js"
        ]
      server:
        files: ["src/server/*.coffee"]
        tasks: ["coffee:server"]


  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-concat"

  grunt.loadNpmTasks "grunt-contrib-jade"

  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"

  grunt.loadNpmTasks "grunt-contrib-watch"


  grunt.registerTask "default", [
    "copy"

    "jade"

    "compass"
    "cssmin"

    "coffee"
    "uglify"
  ]

  grunt.registerTask "production", [
    "copy"

    "jade"

    "compass"
    "cssmin"

    "coffee"
    "concat:analytics"
    "uglify"
  ]
