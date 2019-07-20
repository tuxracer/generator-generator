path = require 'path'
Generator = require 'yeoman-generator'
askName = require 'inquirer-npm-name'
_ = require 'lodash'
extend = require 'deep-extend'
mkdirp = require 'mkdirp'

makeGeneratorName = (name) ->
  name = _.kebabCase(name)
  name =
    if name.indexOf('generator-') is 0
      name
    else
      'generator-' + name

module.exports = class extends Generator
  initializing: ->
    @props = {}

  prompting: ->
    askName {
      name: 'name'
      message: 'Your generator name',
      default: makeGeneratorName path.basename(process.cwd())
      filter: makeGeneratorName,
      validate: (str)->
        str.length > 'generator-'.length
    }, this
    .then (props) =>
      @props.name = props.name

  default: ->
    if path.basename(@destinationPath()) isnt @props.name
      this.log "Your generator must be inside a folder named #{@props.name}\n\
        I'll automatically create this folder."
      mkdirp @props.name
      @destinationRoot @destinationPath(@props.name)

    readmeTpl = _.template @fs.read(@templatePath('README.md'))

    @composeWith require.resolve('generator-node/generators/app'), {
      boilerplate: false
      name: @props.name
      projectRoot: 'generators'
      skipInstall: @options.skipInstall
      readme: readmeTpl {
        generatorName: @props.name
        yoName: @props.name.replace 'generator-', ''
      }
    }

    @composeWith require.resolve('../subgenerator'), {
      arguments: ['app']
    }

  writing: ->
    pkg = @fs.readJSON @destinationPath('package.json'), {}
    generatorGeneratorPkg = require '../package.json'

    extend pkg,
      dependencies:
        'yeoman-generator':
          generatorGeneratorPkg.dependencies['yeoman-generator']
        chalk:
          generatorGeneratorPkg.dependencies.chalk
        yosay: generatorGeneratorPkg.dependencies.yosay
        coffeescript: generatorGeneratorPkg.dependencies.coffeescript
      devDependencies:
        'yeoman-test':
          generatorGeneratorPkg.devDependencies['yeoman-test']
        'yeoman-assert':
          generatorGeneratorPkg.devDependencies['yeoman-assert']
      jest:
        testPathIgnorePatterns: ['templates']
    pkg.keywords = pkg.keywords or []
    pkg.keywords.push 'yeoman-generator'

    @fs.writeJSON @destinationPath('package.json'), pkg

  conflicts: ->
    @fs.append @destinationPath('.eslintignore'), '**/templates\n'

  install: ->
    @installDependencies({bower: false})
    return
