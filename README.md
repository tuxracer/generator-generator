# Yeoman Generator for CoffeeScript Yeoman Generators
[![Build Status](https://secure.travis-ci.org/yeoman/generator-generator.png?branch=master)](https://travis-ci.org/yeoman/generator-generator)

Fork of [generator-generator](https://github.com/yeoman/generator-generator) which is maintained by: [Pascal Hartig](https://github.com/passy)

![Yo dawg, I heard you like generators?](http://i.imgur.com/2gqiift.jpg)

`generator-generatorcs` scaffolds out a new basic Yeoman generator with some
sensible defaults.

## Commands

* `yo generatorcs` shows a wizard for generating a new generator
* `yo generatorcs:subgenerator NAME` generates a subgenerator with the name NAME

## What do you get?

`generator-generatorcs` scaffolds out a complete project directory structure for
you.

    .
    ├── app
    │   ├── index.coffee
    │   └── templates
    │       ├── editorconfig
    │       └── jshintrc
    ├── .editorconfig
    ├── .gitattributes
    ├── .gitignore
    ├── .jshintrc
    ├── LICENSE
    ├── package.json
    ├── README.md
    └── test
        ├── test-creation.js
        └── test-load.js

## Getting started
- Install: `npm install -g generator-generatorcs`
- Run: `yo generatorcs`

## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
