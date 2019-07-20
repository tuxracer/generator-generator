'use strict';
const util = require('util');
const yeoman = require('yeoman-generator');

const FooGenerator = function() {
  // By calling `NamedBase` here, we get the argument to the subgenerator call
  // as `this.name`.
  yeoman.generators.NamedBase.apply(this, arguments);

  console.log('You called the foo subgenerator with the argument ' + this.name + '.');
};

util.inherits(FooGenerator, yeoman.generators.NamedBase);

FooGenerator.prototype.files = function() {
  this.copy('somefile.js', 'somefile.js');
};

module.exports = FooGenerator;
