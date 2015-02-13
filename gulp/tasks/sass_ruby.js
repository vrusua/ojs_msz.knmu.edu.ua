var gulp         = require('gulp');
var browserSync  = require('browser-sync');

var sass_ruby    = require('gulp-ruby-sass'); // компиляция SASS (ruby)

var sourcemaps   = require('gulp-sourcemaps');
var handleErrors = require('../util/handleErrors');
var config       = require('../config').sass_ruby;
var autoprefixer = require('gulp-autoprefixer'); // Добавление вендорных префиксов

//  Компиляция SASS/SCSS - SASS_RUBY

gulp.task('sass_ruby', ['images'], function () {
  return gulp.src(config.src)
    .pipe(sass_ruby(config.settings))
    .on('error', handleErrors)
    .pipe(sourcemaps.write())
    .pipe(autoprefixer({ browsers: ['last 2 version'] }))
    .pipe(gulp.dest(config.dest))
    .pipe(browserSync.reload({stream:true}));
});
