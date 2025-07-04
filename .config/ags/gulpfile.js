const { spawn } = require('child_process');
const watch = require('gulp-watch');

let agsProcess = null;

function startAgs() {
  if (agsProcess) {
    spawn('pkill', ['gjs'])
    agsProcess = null
  }

  if (!agsProcess) {
    console.log('_' * 20, "Started", '_' * 20)
    agsProcess = spawn('ags', ['run', '--gtk', '4']);
    agsProcess.stdout.on('data', (data) => {
      console.log(`AGS: ${data}`);
    });
    agsProcess.stderr.on('data', (data) => {
      console.error(`AGS Error: ${data}`);
    });
  }
}

function watchFiles() {
  watch([
    '**/*.ts',
    '**/*.tsx',
    '**/*.scss',
    '**/*.js',
    'widgets/*.tsx',
    'widget/*.tsx'
  ], function() {
    startAgs();
  });
}

exports.watch = watchFiles;
exports.default = watchFiles; 
