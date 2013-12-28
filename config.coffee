exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    assets: /^app\/assets\//
  modules:
    definition: false
    wrapper: false
  paths:
    public: '_public'
  files:
    javascripts:
      joinTo:
        'js/shame.js': /^app/
        'js/vendor.js': /^(bower_components|vendor)/

    stylesheets:
      joinTo:
        'css/shame.css': /^(app|vendor|bower_components)/

    templates:
      joinTo: 
        'js/dontUseMe' : /^app/ # dirty hack for Jade compiling.

  server:
    path: 'server.coffee'

  # Enable or disable minifying of result js / css files.
  # minify: true
