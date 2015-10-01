#!/usr/bin/env node
'use strict';

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }

var _request = require('request');

var _request2 = _interopRequireDefault(_request);

var _yargs = require('yargs');

var _yargs2 = _interopRequireDefault(_yargs);

var _path = require('path');

var _path2 = _interopRequireDefault(_path);

var PORT = 12345;
var argv = _yargs2['default'].argv;

if (argv._.length <= 0) {
  console.log('Usage: atom-it <directory>');
  process.exit();
}

var willOpenDir = _path2['default'].resolve(process.cwd(), argv._[0]);

_request2['default'].post('http://localhost:' + PORT).form({
  dir: willOpenDir
});