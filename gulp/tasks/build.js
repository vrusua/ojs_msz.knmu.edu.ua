var gulp = require('gulp');

gulp.task('build', ['browserify', 'sass_ruby', 'images', 'markup', 'jade']);
//gulp.task('build', ['browserify', 'sass_libsass', 'images', 'markup', 'jade']);
