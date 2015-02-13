var gulp = require('gulp');
var config = require('../config').jade
var gulpJade = require('gulp-jade');


// Генерирование jade шаблонов
gulp.task('jade', function() {
  return gulp.src(config.src).pipe(gulpJade({
    pretty: true
  })).pipe(gulp.dest(config.dest));
});