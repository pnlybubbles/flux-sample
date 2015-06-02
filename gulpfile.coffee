gulp = require 'gulp'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
buffer = require 'vinyl-buffer'
# source = require 'vinyl-source-stream'
# browserify = require 'browserify'
# watchify = require 'watchify'
watchify = require 'gulp-watchify'
reactify = require 'coffee-reactify'
gutil = require 'gulp-util'
plumber = require 'gulp-plumber'
rename = require 'gulp-rename'
# _ = require 'lodash'

gulp.task 'default', ['build']
gulp.task 'build', ['build:others', 'browserify']
others = []
gulp.task 'build:others', ("build:#{o}" for o in others)

watching = false
gulp.task 'enable-watch-mode', -> watching = true
gulp.task 'watchify', ['enable-watch-mode', 'browserify']
gulp.task 'watch', ['build:others', 'enable-watch-mode', 'watchify'], ->
  for o in others
    gulp.watch "src/**/*.#{o}", ["build:#{o}"]

customOpts =
  entries: ['./src/main.coffee']
  extensions: ['.coffee', '.js']
  debug: true

# gulp.task 'browserify', ->
#   opts = _.assign {}, watchify.args, customOpts
#   bundler = (if watching then watchify browserify(opts) else browserify(opts))

#   bundle = ->
#     gutil.log 'parsing...'
#     bundler
#       .on 'error', gutil.log.bind(gutil, 'Browserify Error')
#       .transform harmony: true, reactify
#       .bundle()
#       .pipe source('bundle.js')
#       .pipe buffer()
#       .pipe sourcemaps.init
#         loadMaps: true
#       .pipe uglify()
#       .pipe sourcemaps.write('./')
#       .pipe gulp.dest('public/js')

#   bundler.on 'update', bundle
#   bundler.on 'log', gutil.log
#   bundle()

gulp.task 'browserify', watchify (watchify) ->
  gulp
    .src 'src/main.coffee'
      .pipe plumber()
      .pipe watchify
        watch: watching
        extensions: ['.coffee', '.js']
        debug: true
        transform: ['coffee-reactify']
      .pipe buffer()
      .pipe sourcemaps.init
        loadMaps: true
      .pipe uglify()
      .pipe rename('bundle.js')
      .pipe sourcemaps.write('./')
      .pipe gulp.dest('public/js')
