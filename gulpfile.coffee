gulp = require 'gulp'
coffee = require 'gulp-coffee'
watchify = require 'gulp-watchify'
rename = require 'gulp-rename'

gulp.task 'default', ['build']
gulp.task 'build', [
  'build:coffee'
]

gulp.task 'build:coffee', ->
  gulp
    .src 'src/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest('lib')

watching = false
gulp.task 'enable-watch-mode', -> watching = true
gulp.task 'browserify', watchify (watchify) ->
  gulp
    .src 'lib/main.js'
    .pipe watchify
      watch: watching
    .pipe rename('bundle.js')
    .pipe gulp.dest('public/js')

gulp.task 'watchify', ['enable-watch-mode', 'browserify']
gulp.task 'watch', ['build', 'enable-watch-mode', 'watchify'], ->
  gulp.watch 'src/**/*.coffee', ['build:coffee']
