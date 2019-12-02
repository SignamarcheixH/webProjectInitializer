#!/bin/bash

#######################################
########    V A R I A B L E S   #######
#######################################

htmlMainFileName="index.html"
cssFolderName="scss"
cssPagesFolder="pages"
cssComponentsFolder="components"
cssMixinsFolder="mixins"
$cssMainFileName="main.min.css"
javascriptFolderName="javascript"
javascriptMainFileName="script.js"
destinationFolderName="dist"
resourcesFolderName="ressources"

#######################################
########    H I E R A R C H Y    ######
#######################################

read -p "Entrez le nom du projet : " repoName
mkdir $repoName
cd $repoName

########## G L O B A L #################

mkdir $cssFolderName
mkdir $javascriptFolderName
mkdir $resourcesFolderName
mkdir $destinationFolderName
touch $htmlMainFileName
touch .gitignore

########## H T M L #####################

hrefAttribute="href=\"$destinationFolderName/$cssMainFileName\""
srcAttribute="src=\"$javascriptFolderName/$javascriptMainFileName\""

cat <<EOT >> $htmlMainFileName
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <title>$repoName</title>
        <link rel="stylesheet" $hrefAttribute>
    </head>
    <body>
    	<h1>Project built and ready to start !</h1>
        <script $srcAttribute></script>
    </body>
</html>
EOT


########## C S S #########################

touch $cssFolderName/$scssMainFileName
mkdir $cssFolderName/$cssPagesFolder
mkdir $cssFolderName/$cssComponentsFolder
mkdir $cssFolderName/$cssMixinsFolder

########## J A V A S C R I P T ###########
 
touch $javascriptFolderName/$javascriptMainFileName

touch package.json
cat <<EOT >> package.json
{
  "name": "",
  "version": "1.0.0",
  "description": "",
  "author": "",
  "private": true,
  "dependencies": {
    "axios": "^0.19.0",
    "browserify": "^16.5.0",
    "gulp": "^4.0.2",
    "gulp-sass": "^4.0.2",
    "@babel/core": "^7.7.4",
    "gulp-babel": "^8.0.0",
    "gulp-concat": "2.6.1",
    "gulp-uglify": "3.0.2",
    "gulp-rename": "^1.4.0"
  }
}
EOT

if hash npm 2>/dev/null; then
	npm install
	touch gulpfile.js
	cat <<EOT >> gulpfile.js
var gulp = require('gulp');
var sass = require('gulp-sass');
var babel = require('gulp-babel');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
 
var paths = {
  styles: {
    src: 'scss/**/*.scss',
    dest: 'dist/'
  },
  scripts: {
    src: 'javascript/**/*.js',
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
    .pipe(gulp.dest(paths.styles.dest));
}
 
function scripts() {
  return gulp.src(paths.scripts.src, { sourcemaps: true })
    .pipe(babel())
    .pipe(uglify())
    .pipe(concat('main.min.js'))
    .pipe(gulp.dest(paths.scripts.dest));
}
 
function watch() {
  gulp.watch(paths.scripts.src, scripts);
  gulp.watch(paths.styles.src, styles);
}
 
var build = gulp.series(gulp.parallel(styles, scripts));
 
exports.styles = styles;
exports.scripts = scripts;
exports.watch = watch;
exports.build = build;

exports.default = build;
EOT

fi

########## G I T #########################

cat <<EOT >> .gitignore
style.css.map
node_modules/
EOT