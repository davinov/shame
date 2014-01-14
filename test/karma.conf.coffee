module.exports = (karma) ->
  karma.set

  # base path, that will be used to resolve files and exclude
    basePath: "../"

  # frameworks to use
    frameworks: [
      "mocha"
      "chai"
    ]

  # list of files / patterns to load in the browser

  # Program files

  # Load mocks directly from bower
    files: [
      "bower_components/angular/angular.js"
      "bower_components/angular-route/angular-route.js"
      "bower_components/angular-resource/angular-resource.js"
      "bower_components/jquery/jquery.js"
      "bower_components/bootstrap/dist/js/bootstrap.js"
      "bower_components/angular-bootstrap/ui-bootstrap.js"
      "bower_components/angular-easyfb/angular-easyfb.js"
      "app/**/*.coffee"
      "bower_components/angular-mocks/angular-mocks.js"
      "test/client/**/*.spec.*"
    ]
    preprocessors:
      "**/*.coffee": "coffee"

  # list of files to exclude
    exclude: []

  # test results reporter to use
  # possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: [
      "progress"
      "growl"
      "coverage"
    ]
    coverageReporter:
      type: "lcovonly"
      dir: "coverage/"


  # web server port
    port: 9876

  # cli runner port
    runnerPort: 9100

  # enable / disable colors in the output (reporters and logs)
    colors: true

  # level of logging
  # possible values: karma.LOG_DISABLE || karma.LOG_ERROR || karma.LOG_WARN || karma.LOG_INFO || karma.LOG_DEBUG
    logLevel: karma.LOG_INFO

  # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true
    browsers: [
      "PhantomJS"
    ]

  # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000

  # Continuous Integration mode
  # if true, it capture browsers, run tests and exit
    singleRun: true
