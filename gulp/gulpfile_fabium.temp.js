
//##################################################################################
//##### Зависимости
//##################################################################################

// _gulp-boilerplate
var
  gutil = require('gulp-util'),
  jshint = require("gulp-jshint"),
  csslint = require('gulp-csslint'),
  sass = require('gulp-sass'),
  clean = require('gulp-clean'),
  gulpkss = require('gulp-kss'),
  compass = require('gulp-compass'),
  livereload = require('gulp-livereload'),
  open = require("gulp-open"),
  notify = require("gulp-notify"),
  lr = require('tiny-lr'),
  server = lr();
  port = 80;

var config, consoleErorr, fs, g, gulp, gulpLoadPlugins, pngcrush, yaml;

// node modules
fs = require('fs');
yaml = require('js-yaml');
pngcrush = require('imagemin-pngcrush');

// include gulp
gulp = require('gulp');
// gulp plugins load by pattern
g = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'gulp.*'],
  replaceString: /\bgulp[\-.]/
});

// config.yml file - define base folders
config = yaml.load(fs.readFileSync("config.yml", "utf8"));

//##################################################################################
//##### Функции-помощники
//##################################################################################

// Если случается ошибка при работе галпа, воспроизводтся звук
consoleErorr = function(err) {
  g.util.beep();
  console.log(err.message);
};

//##################################################################################
//##### Таски
//##################################################################################

// Генерация документации - KSS
gulp.task('kss', function () {
  //Clean out the current documentation folder
  gulp.src([
    '../built/styleguide/**/*'
  ], {read: false})
    .pipe(clean({force: true}))

  //Create the fresh documentation by reading through the sass files
  gulp.src(['../src/css/styleguide/**/*.scss'])
    .pipe(gulpkss({
      overview: '../src/css/styleguide/styleguide.md' //Absolute path to markdown file which is used for styleguide home page
      // templateDirectory: Absolute path to template directory, by default kss-node default template is used.
      // kss: Options supported by KSS-Node (https://github.com/hughsk/kss-node)
    }))
    // .pipe(gulp.dest( dist + '/styleguide/'));
    .pipe(gulp.dest( '../built/styleguide/'));

  //Compile the KSS documentation page's style sheet so the styles will load accurately within the docs
  gulp.src( '../src/css/styleguide/style.scss')
    .pipe(sass())
    .pipe(gulp.dest( '../built/styleguide/public'));

  //Add any styleguide images
  gulp.src( '../src/i/styleguide/**/*')
    .pipe(gulp.dest( '../built/styleguide/'));
});

// Генерация документации 2 - KSS
gulp.task('kss2', function () {
  //Clean out the current documentation folder
  gulp.src([
    '../built/styleguide2/**/*'
  ], {read: false})
    .pipe(clean({force: true}))

  //Create the fresh documentation by reading through the sass files
  gulp.src(['../src/css/styleguide2/**/*.scss'])
    .pipe(gulpkss({
      overview: '../src/css/styleguide2/readme.md' //Absolute path to markdown file which is used for styleguide home page
      // templateDirectory: Absolute path to template directory, by default kss-node default template is used.
      // kss: Options supported by KSS-Node (https://github.com/hughsk/kss-node)
    }))
    // .pipe(gulp.dest( dist + '/styleguide/'));
    .pipe(gulp.dest( '../built/styleguide2/'));

  //Compile the KSS documentation page's style sheet so the styles will load accurately within the docs
  gulp.src( '../src/css/styleguide2/style.scss')
    .pipe(sass())
    .pipe(gulp.dest( '../built/styleguide2/public'));

  //Add any styleguide images
  gulp.src( '../src/i/styleguide2/**/*')
    .pipe(gulp.dest( '../built/styleguide2/'));
});


// Генерация спрайтов
gulp.task('sprite', function() {
  var spriteData;
  spriteData = gulp.src(config.paths.src.sprites.images.all).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.spritesmith({
    imgName: 'sprite.png',
    cssName: 'sprite.scss',
    padding: 2,
    cssFormat: 'scss',
    algorithm: 'binary-tree',
    cssTemplate: 'stylus.template.mustache',
    cssVarMap: function(sprite) {
      sprite.name = 's-' + sprite.name;
    }
  }));
  spriteData.img.pipe(gulp.dest(config.paths.built.images.design.path));
  spriteData.css.pipe(gulp.dest(config.paths.src.sprites.style));
});

// Компиляция coffee в js
gulp.task('coffee', function() {
  return gulp.src(config.paths.src.scripts.local.all).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.coffee({
    bare: true
  })).pipe(gulp.dest(config.paths.built.scripts.local.path));
});

// перенос скриптов из папки вендор в built
gulp.task('vendor', function() {
  return gulp.src(config.paths.src.scripts.vendor.all).pipe(gulp.dest(config.paths.built.scripts.vendor.path));
});

// перенос скриптов inter из папки build в built
gulp.task('inter_js', function() {
  return gulp.src(config.paths.src.scripts.inter.all).pipe(gulp.dest(config.paths.built.scripts.inter.path));
});

// перенос стилей inter из папки build в built
gulp.task('inter_css', function() {
  //return gulp.src(config.paths.src.styles.inter.main).pipe(gulp.dest(config.paths.built.styles.path));
  return gulp.src(config.paths.src.styles.inter.all)
    .pipe(g.concat('screen.css'))
    .pipe(g.minifyCss())
    .pipe(gulp.dest(config.paths.built.styles.path));
});

// gulp.task('scripts', ['coffee', 'vendor']);
gulp.task('scripts', ['inter_css']);

//  Компиляция SCSS в CSS
gulp.task('sass', function() {
  return gulp.src(config.paths.src.styles.main).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.sass())
  .pipe(gulp.dest(config.paths.built.styles.path))
  .pipe(g.notify({ message: 'SASS build complete' }));
});

// Компиляция stylus в css
gulp.task('stylus', function() {
  return gulp.src(config.paths.src.styles.main).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.stylus()).pipe(gulp.dest(config.paths.built.styles.path));
});

// Копирование картинок из src в built
gulp.task('images', function() {
  return gulp.src([config.paths.src.images.all, '!' + config.paths.src.sprites.images.all]).pipe(gulp.dest(config.paths.built.images.path));
});

// Генерирование jade шаблонов
// Генерируется только папка pages
gulp.task('jade', function() {
  return gulp.src(config.paths.src.templates.pages.all).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.jade({
    pretty: true
  })).pipe(gulp.dest(config.paths.built.path));
});

// Добавление вендорных префиксов
gulp.task('autoprefixer', function() {
  return gulp.src(config.paths.built.styles.all).pipe(g.autoprefixer()).pipe(gulp.dest(config.paths.built.styles.path));
});


//##################################################################################
//##### Такси оптимизации
//##################################################################################

// Оптимизация скриптов
gulp.task('scripts:min', function() {
  return gulp.src(config.paths.built.scripts.all).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.uglify()).pipe(gulp.dest(config.paths.built.scripts.path));
});

// Оптимизация картинок
gulp.task('images:min', function() {
  return gulp.src(config.paths.built.images.all).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.imagemin({
    progressive: true,
    svgoPlugins: [
      {
        removeViewBox: false
      }
    ],
    use: [pngcrush()]
  })).pipe(gulp.dest(config.paths.built.images.path));
});

// Оптимизация стилей
gulp.task('styles:min', function() {
  return gulp.src(config.paths.built.styles.all).pipe(g.plumber({
    errorHandler: consoleErorr
  })).pipe(g.minifyCss()).pipe(gulp.dest(config.paths.built.styles.path));
});

// jshint
gulp.task('jshint', function() {
  return gulp.src('js/*.js')
  .pipe(jshint())
  .pipe(jshint.reporter('devwatch'));
});

// csslint
gulp.task('csslint', function() {
  gulp.src('css/*.css')
    .pipe(csslint('csslintrc.json'))
    .pipe(csslint.reporter());
});

// запуск локального сервера
gulp.task('connect', function(next) {
  var staticS = require('node-static'),
    srv = new staticS.Server('./../built/');

  require('http').createServer(function (request, response) {
    request.addListener('end', function () {
      srv.serve(request, response);
    }).resume();
  }).listen(port, function() {
    gutil.log('Server listening on port: ' + gutil.colors.yellow(port));
    next();
  });
});

// вызов браузера и открытие localhost
gulp.task("launch", function(){
  var options = {
      url: "http://127.0.0.1:" + port,
      app: "chrome"
    };
    gulp.src("./../built/index.html")
      .pipe(open("", options));
});

// Отслеживание изменения файлов
gulp.task('watch', function() {
  var server = livereload();

  gulp.watch(config.paths.src.scripts_coffee.local.all, ['coffee']);
  gulp.watch(config.paths.src.scripts.local.all, ['jshint'], function(file) {
    gulp.run('jshint');
    server.changed(file.path);
  });
  gulp.watch(config.paths.src.scripts.vendor.all, ['vendor']);

  gulp.watch(config.paths.src.styles.all, ['sass']);
  // gulp.watch(config.paths.src.styles.all, ['stylus']);

  gulp.watch(config.paths.src.images.all, ['images']);
  gulp.watch(config.paths.src.sprites.images.all, ['sprite']);

  gulp.watch(config.paths.src.templates.all, ['jade']);
});

// Отслеживание изменения файлов
gulp.task('watch_theme', function() {
  var server = livereload();
  gulp.watch(config.paths.src.styles.inter.all, ['inter_css']);
});

/*
  gulp.watch('js/*.js', ['jshint'], function(file) {
    gulp.run('jshint');
    server.changed(file.path);
  });

  gulp.watch('scss/*.scss', ['sass']);

  gulp.watch('css/*.css').on('change', function(file) {
    gulp.run('csslint');
    server.changed(file.path);
  });

  gulp.watch('*.html').on('change', function(file) {
    server.changed(file.path);
  });

*/
//##################################################################################
//##### Таски по группам
//##################################################################################

// Выполнение всех тасков
gulp.task('default', ['sprite', 'stylus', 'scripts', 'images', 'jade']);

// Dev таск для разработки с отслеживанием измнений файлов и компиляцией их на лету
gulp.task('dev', ['default', 'watch']);
gulp.task('devwatch', ['default','connect', 'launch', 'watch']);

// минификация js, css и оптимизация изображений.
gulp.task('minify', ['scripts:min', 'styles:min', 'images:min']);

// Подготовка проекта для продакшена. Исполнение всех задах + минификация файлов
gulp.task('prod', ['default', 'autoprefixer'], function() {
  return gulp.start('minify');
});

// ############### UNTESTED ##################


/*
gulp.task('livingstyleguide', function () {
    gulp.src('./source/index.html.lsg')
        .pipe(livingstyleguide())
        .pipe(gulp.dest('dist'));
});
*/
