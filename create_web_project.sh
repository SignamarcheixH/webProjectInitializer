#!/bin/bash

#######################################
########    V A R I A B L E S   ##################
#######################################

htmlMainFileName="index.html"
cssFolderName="css"
cssMainFileName="style.css"
javascriptFolderName="javascript"
javascriptMainFileName="script.js"
resourcesFolderName="ressources"
todoFileName="todo.txt"

#######################################
########    H I E R A R C H Y    #################
#######################################

read -p "Entrez le nom du projet : " repoName
mkdir $repoName
cd $repoName

########## G L O B A L #####################

mkdir $cssFolderName
mkdir $javascriptFolderName
mkdir $resourcesFolderName
touch $todoFileName
touch $htmlMainFileName

########## H T M L #######################

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
        $todoFileName
        <body>
              <script $srcAttribute></script>
        </body>
</html>
EOT


########## C S S #########################

cd $cssFolderName
touch $cssMainFileName
cd ..

########## J A V A S C R I P T #################

cd $javascriptFolderName
touch $javascriptMainFileName
