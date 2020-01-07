#!/bin/bash

#######################################
########    V A R I A B L E S   #######
#######################################

htmlMainFileName="index.html"
cssFolderName="scss"
cssPagesFolder="pages"
cssComponentsFolder="components"
cssMixinsFolder="mixins"
cssMainFileName="main.min.css"
scssMainFileName="style.scss"
javascriptFolderName="javascript"
javascriptSubFolderName="js"
vueSubFolderName="vue"
javascriptMainFileName="main.min.js"
vueMainFileName="main-vue.min.js"
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
mkdir $javascriptFolderName/$javascriptSubFolderName
mkdir $javascriptFolderName/$vueSubFolderName
mkdir $resourcesFolderName
mkdir $destinationFolderName
touch $htmlMainFileName
touch .gitignore

########## H T M L #####################

hrefAttribute="href=\"$destinationFolderName/$cssMainFileName\""
srcAttribute="src=\"$destinationFolderName/$javascriptMainFileName\""
vueSrcAttribute="src=\"$destinationFolderName/$vueMainFileName\""

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
      <script $vueSrcAttribute></script>
      <script $srcAttribute></script>
    </body>
</html>
EOT


########## C S S #########################

touch $cssFolderName/$scssMainFileName 
cat <<EOT >> $cssFolderName/$scssMainFileName
//$cssPagesFolder

//$cssComponentsFolder

//$cssMixinsFolder
EOT
mkdir $cssFolderName/$cssPagesFolder
mkdir $cssFolderName/$cssComponentsFolder
mkdir $cssFolderName/$cssMixinsFolder

########## J A V A S C R I P T ###########
 
touch $javascriptFolderName/$javascriptSubFolderName/$javascriptMainFileName
touch $javascriptFolderName/$vueSubFolderName/$vueMainFileName

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
    "fs": "^0.0.1-security",
    "gulp": "^4.0.2",
    "gulp-sass": "^4.0.2",
    "@babel/core": "^7.7.4",
    "@babel/preset-env": "^7.1.5",
    "gulp-babel": "^8.0.0",
    "gulp-concat": "2.6.1",
    "gulp-livereload": "^4.0.1",
    "gulp-notify": "^3.2.0",
    "gulp-uglify": "3.0.2",
    "gulp-rename": "^1.4.0",
    "gulp-sourcemaps": "^2.6.4",
    "gulp-tap": "^2.0.0",
    "vue": "^2.6.10"
  }
}
EOT

if hash npm 2>/dev/null; then
	npm install
	touch gulpfile.js
  cat ../file_samples/vue.js >> $destinationFolderName/$vueMainFileName
	cat ../file_samples/gulpfile_sample.txt >> gulpfile.js
fi

########## G I T #########################

cat <<EOT >> .gitignore
package-lock.json
node_modules/
*.map
EOT