#!/bin/bash

#######################################
########    V A R I A B L E S   #######
#######################################

htmlMainFileName="index.html"
cssFolderName="scss"
cssMainFileName="style.css"
scssMainFileName="style.scss"
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
if hash sass 2>/dev/null; then
	sass $cssFolderName/$scssMainFileName:$destinationFolderName/$cssMainFileName
else
	touch $destinationFolderName/$cssMainFileName
fi

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
    "browserify": "^16.5.0"
  }
}
EOT

if hash npm 2>/dev/null; then
	npm install
fi

########## G I T #########################

cat <<EOT >> .gitignore
style.css.map
node_modules/
EOT