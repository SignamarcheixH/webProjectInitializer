const babel = require('gulp-babel');
const concat = require('gulp-concat');
const fs = require('fs');
const gulp = require('gulp');
const livereload = require('gulp-livereload');
const notify = require("gulp-notify");
const rename = require('gulp-rename');
const sass = require('gulp-sass');
const sourcemaps = require('gulp-sourcemaps');
const tap = require('gulp-tap');
const uglify = require('gulp-uglify');

 
const paths = {
  styles: {
    src: 'scss/style.scss',
    dest: 'dist/'
  },
  scripts: {
    src: 'javascript/js/**/*.js',
    dest: 'dist/'
  },
  vuescripts: {
    src: 'javascript/vue/**/*.js',
    dest: 'dist/'
  }
};

 
/*
 * Define our tasks using plain functions
 */

function styles() {
  return gulp.src(paths.styles.src)
    .pipe(sass())
    .pipe(rename(
      {
        basename: 'main',
        suffix: '.min'
      }
    ))
    .pipe(notify({ message: 'CSS generated' }))
    .pipe(gulp.dest(paths.styles.dest));
}
 
function scripts() {
  return gulp.src(paths.scripts.src, { sourcemaps: true })
    .pipe(babel({presets: ["@babel/preset-env"]}))
    .pipe(uglify())
    .pipe(concat('main.min.js'))
    .pipe(notify({ message: 'JS generated' }))
    .pipe(gulp.dest(paths.scripts.dest));
}
 

function replaceWithTemplate(file) {
  var htmlFileName = file.relative.substring(file.relative.lastIndexOf('/') + 1).slice(0, -2) + 'html';
  var htmlComponentPath = file.path.slice(0, -2) + 'html';
  var htmlContent = fs.readFileSync(htmlComponentPath, 'utf8');
  var re = new RegExp('([\'"`])' + htmlFileName + '([\'"`])', 'gm');
  var replacement = '`' + htmlContent + '`';
  var res = file.contents.toString().replace(re, replacement);
  return res;
}

function vue() {
  return (
    gulp
      .src(paths.vuescripts.src, { sourcemaps: true })
      .pipe(
        tap(function(file, t) {
          if (file.relative.includes('.component.js')) {
            file.contents = Buffer.from(replaceWithTemplate(file));
          }
        })
      )
      .pipe(sourcemaps.init())
      .pipe(
        babel({
          presets: [ '@babel/preset-env' ]
        })
      )
      .pipe(uglify())
      .pipe(concat('main-vue.js'))
      .pipe(gulp.dest(paths.vuescripts.dest))
      .pipe(uglify())
      .pipe(rename({ extname: '.min.js' }))
      .pipe(sourcemaps.write('.'))
      .pipe(gulp.dest(paths.vuescripts.dest))
      .on('error', sass.logError)
      .pipe(notify({ message: 'Vue generated' }))
      .pipe(livereload())
  );
}

function watch() {
  gulp.watch(paths.scripts.src, scripts);
  gulp.watch(paths.styles.src, styles);
  gulp.watch(paths.vuescripts.src, vue)
}
 
const build = gulp.series(gulp.parallel(styles, scripts, vue));

exports.watch = watch;

exports.default = build;