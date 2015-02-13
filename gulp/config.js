var dest = "./built";
var src = './src';

module.exports = {
  browserSync: {
    server: {
      // We're serving the src folder as well
      // for sass sourcemap linking
      baseDir: [dest, src]
    },
    files: [
      dest + "/**",
      // Exclude Map files
      "!" + dest + "/**.map"
    ]
  },
  sass_libsass: {
    src: src + "/styles/**/*.{sass,scss}",
    dest: dest + "/css",
    settings: {
      // Required if you want to use SASS syntax
      // See https://github.com/dlmanning/gulp-sass/issues/81
      sourceComments: 'map',
      imagePath: '/images' // Used by the image-url helper
    }
  },
  sass_ruby: {
    src: src + "/styles/**/*.{sass,scss}",
    dest: dest + "/css",
    settings: {
      compass: true,
      style: 'expanded', // 'compressed'
      'sourcemap=none': true, // #bug / gulp-ruby-sass - will be fixed in v1.0.
      sourcemap: false,
      sourcemapPath: src + "/sass",
      precision: 2
    }
  },
  images: {
    src: src + "/images/**",
    dest: dest + "/i"
  },
  markup: {
    src: src + "/templates/**/*.{htm,html}",
    dest: dest
  },
  jade: {
    src_watch: src + "/templates/**/*.jade",
    src: src + "/templates/**/[^_]*.jade",
    dest: dest
  },
  browserify: {
    // Enable source maps
    debug: true,
    // Additional file extentions to make optional
    extensions: ['.coffee', '.hbs'],
    // A separate bundle will be generated for each
    // bundle config in the list below
    bundleConfigs: [{
      entries: src + '/scripts/app.coffee',
      dest: dest + '/js',
      outputName: 'app.js'
    }, {
      entries: src + '/scripts/head.coffee',
      dest: dest + '/js',
      outputName: 'head.js'
    }, {
      entries: src + '/scripts/clock.coffee',
      dest: dest + '/js',
      outputName: 'clock.js'
    }]
  }
};
