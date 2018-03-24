path = require 'path'
Generator = require 'yeoman-generator'
superb = require 'superb'

module.exports = class extends Generator
  constructor: (args, opts)->
    super(args, opts)

    @argument 'name',
      type: String
      required: true
      description: 'Generator name'

  writing: ->
    generatorName = @fs.readJSON(@destinationPath('package.json')).name

    @fs.copy @templatePath('index.js'),
      @destinationPath(path.join('generators', @options.name, 'index.js'))

    @fs.copyTpl @templatePath('index.coffee'),
      @destinationPath path.join('generators', @options.name, 'index.coffee')
      {
        # Escape apostraphes from superb to not conflict with strings
        superb: superb().replace("'", "\\'")
        generatorName
      }
    @fs.copy @templatePath('templates/**'),
      @destinationPath(path.join('generators', @options.name, 'templates'))

    @fs.copyTpl @templatePath('test.js'),
      @destinationPath('__tests__/' + @options.name + '.js')
      {
        name: @options.name
        generatorName
      }
