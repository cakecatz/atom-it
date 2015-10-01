#!/usr/bin/env node
import request from 'request';
import yargs from 'yargs';
import path from 'path';

const PORT = 12345;
const argv = yargs.argv;

if (argv._.length <= 0) {
  console.log('Usage: atom-it <directory>');
  process.exit();
}

const willOpenDir = path.resolve(process.cwd(), argv._[0]);

request.post(`http://localhost:${PORT}`).form({
  dir: willOpenDir,
});
