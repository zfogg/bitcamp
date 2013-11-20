module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    copy:
      bootstrap:
        files: [
          expand: true
          cwd: "components/bootstrap/dist/css/"
          src: ["*.css"]
          dest: "public/css/"
        ]
      sourcemaps:
        files: [
          expand: true
          flatten: true
          src: ['components/**/*.map']
          dest: "public/js/"
        ]
      public_static:
        files: [
          expand: true
          cwd: "src/public"
          src: ["*"]
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
      public:
        options:
          sourceMap: true
          bare: true
        files:
          "public/js/main.js": [
            "src/public/js/main.coffee"
          ]
      server:
        options:
          bare: true
        files:
          "server.js": [
            "src/server/server.coffee"
          ]

    uglify:
      public:
        options:
          sourceMappingURL: "/js/main.min.map"
          sourceMapIn: "public/js/main.js.map"
          sourceMap: "public/js/main.min.map"
        files:
          "public/js/main.min.js": [
            "public/js/main.js"
          ]
      plugins:
        files:
          "public/js/plugins.min.js": [
            "components/jquery/jquery.min.js"
            "components/bootstrap/dist/js/bootstrap.js"
            "components/underscore/underscore-min.js"
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
        files: [
          "src/public/sass/*.scss"
          "src/public/sass/*.sass"
        ]
        tasks: ["compass:dist"]
      coffee:
        options:
          interrupt: true
          livereload: true
        files: ["src/public/js/**/*.coffee"]
        tasks: ["coffee:public", "uglify:public"]
      livereload:
        options:
          livereload: true
        files: ["public/css/*.css"]
      server:
        files: ["src/server/*.coffee"]
        tasks: ["coffee:server"]

    concat:
      analytics:
        src: ["src/public/js/ga.js", "public/js/main.min.js"]
        dest: "public/js/main.min.js"
        nonull: true


  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-concat"
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

  grunt.registerTask "production", [
    "default"
    "concat:analytics"
  ]
