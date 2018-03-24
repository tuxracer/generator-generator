/* global describe, beforeEach, it */
'use strict';

const path = require('path');
const helpers = require('yeoman-generator').test;

describe('Generator generator', () => {
  beforeEach(function(done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), err => {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('generator:app', ['../../app']);
      this.app.options['skip-install'] = true;
      done();
    });
  });

  it('creates expected files', function(done) {
    const expected = [
      ['package.json', /"name": "generator-temp"/],
      '.gitignore',
      '.gitattributes',
      '.jshintrc',
      '.travis.yml',
      'app/index.js',
      'app/templates/_package.json',
      'app/templates/_bower.json'
    ];

    // Patch the user info to not run into rate limits on travis
    this.app.userInfo = function() {
      this.realname = 'Tyrion Lannister';
      this.email = 'imp@casterlyrock.com';
      this.githubUrl = 'https://github.com/imp';
    };

    helpers.mockPrompt(this.app, {
      githubUser: 'imp',
      generatorName: 'temp'
    });

    this.app.run({}, () => {
      helpers.assertFiles(expected);
      done();
    });
  });
});

describe('Subgenerator subgenerator', () => {
  beforeEach(function(done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), err => {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator(
        'generator:subgenerator',
        ['../../subgenerator'],
        ['foo']
      );
      done();
    });
  });

  it('creates expected files', function(done) {
    const expected = ['foo/index.js', 'foo/templates/somefile.js'];

    this.app.run({}, () => {
      helpers.assertFiles(expected);
      done();
    });
  });
});
