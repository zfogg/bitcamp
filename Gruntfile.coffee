module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    concat:
      options:
        separator: ";\n\n"
        banner: "/*! <%= pkg.name %> - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %> */\n\n"

      plugins:
        src: [
          "components/jquery/jquery.min.js"
          "components/bootstrap/dist/js/bootstrap.js"
          "components/underscore/underscore-min.js"
          "components/backbone/backbone-min.js"
          "components/handlebars.js/dist/handlebars.js"
        ]
        dest: "public/js/plugins.js"

    copy:
      normalize:
        files: [
          expand: true
          cwd: "components/normalize-css/"
          src: "normalize.css"
          dest: "public/css/"
          filter: "isFile"
        ]

      fontawesomecss:
        files: [
          {
            expand: true
            cwd: "components/font-awesome/css/"
            src: "font-awesome.min.css"
            dest: "public/css/"
            filter: "isFile"
          }
          {
            expand: true
            cwd: "components/font-awesome/font/"
            src: "*"
            dest: "public/font/"
          }
        ]

      favicon:
        files: [
          expand: true
          cwd: "src/public/"
          src: "favicon.ico"
          dest: "public/"
          filter: "isFile"
        ]

      bootstrap:
        files: [
          expand: true
          cwd: "components/bootstrap/dist/css/"
          src: "*.css"
          dest: "public/css/"
        ]

    coffee:
      cpublic:
        files:
          "public/js/main.js": "src/public/javascript/main.coffee"

      cserver:
        files:
          "server.js": "src/server/server.coffee"

    compass:
      dist:
        options:
          config: 'compass.config.rb'

    jade:
      compile:
        options:
          pretty: true
          data:
            debug: false

        files:
          "public/index.html": ["src/public/jade/index.jade"]

    watch:
      options: livereload: true
      html:
        files: ["src/public/jade/**/*.jade"]
        tasks: ["jade"]
      css:
        files: ["src/public/sass/*.scss"]
        tasks: ["compass"]
      js:
        files: ["src/public/javascript/**/*.jade"]
        tasks: ["coffee"]

  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.registerTask "default", [
    "copy"
    "concat"
    "jade"
    "coffee"
    "compass"
  ]
