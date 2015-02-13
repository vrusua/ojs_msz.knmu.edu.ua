/* Notes:
   - gulp/tasks/browserify.js handles js recompiling with watchify
   - gulp/tasks/browserSync.js watches and reloads compiled files
*/

var gulp  = require('gulp');
var config= require('../config');

gulp.task('watch', ['setWatch', 'browserSync'], function() {
  gulp.watch(config.sass_ruby.src, ['sass_ruby']);
//  gulp.watch(config.sass_libsass.src, ['sass_libsass']);
  gulp.watch(config.images.src, ['images']);
  gulp.watch(config.markup.src, ['markup']);
  gulp.watch(config.jade.src_watch, ['jade']);  
});
