#! /bin/bash
DIRECTORY_TO_OBSERVE="src/ tests/"
function block_for_change {
  inotifywait -r \
    -e modify,move,create,delete \
    $DIRECTORY_TO_OBSERVE
}
BUILD_SCRIPT="elm-test $1"
function build {
  $BUILD_SCRIPT
}
build
while block_for_change; do
  build
done

