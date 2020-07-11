#!/bin/bash

elementsToKeep='.gitignore, .git, source, README.md, github_pages_build.sh'

listElementsToRemove() {
    formattedElementsToKeep=$(echo $elementsToKeep | sed "s#, #\\\|#g")
    ls --all | grep --invert-match "$formattedElementsToKeep"
}

removeElementsToRemove() {
    echo "Removing $elementsToRemove..."
    rm -rf $(listElementsToRemove)
}

buildDistFolder() {
    if [[ $(pwd) != *"source"* ]]; then
        cd './source'
    fi
    npm run generate
}

moveDistFilesToRoot() {
    mv --force ./dist/* ../
    mv --force ./dist/.* ../
}

removeElementsToRemove
buildDistFolder
moveDistFilesToRoot

