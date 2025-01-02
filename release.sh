#!/usr/bin/env bash
set -e
BASEDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if command -v jdk21; then
  . jdk21
fi
mvn -Prelease clean site deploy
echo "creating the viewer zip"
cd "$BASEDIR/viewer"
source ./createApp.sh skipInstructions
echo "build the runtime fatjar"
cd "$BASEDIR/runtime"
mvn -DskipTests -Pfatjar -q package
echo "Released and ready for manual release at github!"