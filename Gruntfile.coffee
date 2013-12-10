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
      public:
        options:
          sourceMap: true
          bare: true
        files:
          "build/js/main.js": ["src/public/js/main.coffee"]

      server:
        options:
          bare: true
        files:
          "server.js": ["src/server/server.coffee"]

    concat:
      analytics:
        src: ["src/public/js/ga.js", "build/js/main.js"]
        dest: "build/js/main.js"
        nonull: true

    uglify:
      public:
        options:
          sourceMappingURL: "/js/main.js.map"
          sourceMapIn: "build/js/main.js.map"
          sourceMap: "public/js/main.js.map"
        files:
          "public/js/main.min.js": [
            "components/jquery/jquery.min.js"
            #"components/underscore/underscore-min.js"
            "build/js/main.js"
          ]

    watch:
      html:
        options:
          interrupt: true
          livereload: true
        files: ["src/public/jade/**/*.jade"]
        tasks: ["jade"]

      css:
        options:
          interrupt: true
        files: ["src/public/css/*.scss", "src/public/css/*.sass"]
        tasks: ["compass", "cssmin"]

      coffee:
        options:
          interrupt: true
          livereload: true
        files: ["src/public/js/**/*.coffee"]
        tasks: ["coffee:public", "uglify:public"]

      livereload:
        options:
          interrupt: true
          livereload: true
        files: ["public/css/*.css"]

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
