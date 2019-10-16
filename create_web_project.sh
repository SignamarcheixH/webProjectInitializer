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
touch $htmlMainFileName
touch .gitignore

########## H T M L #####################

hrefAttribute="href=\"$cssFolderName/$cssMainFileName\""
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
sass $cssFolderName/$scssMainFileName:$cssMainFileName

########## J A V A S C R I P T ###########
 
touch $javascriptFolderName/$javascriptMainFileName

########## G I T #########################

cat <<EOT >> .gitignore
style.css.map
EOT