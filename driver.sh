#!/bin/bash

set -e

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <THEMES_SOURCE> <IOS_OUTPUT_DESTINATION> <ANDROID_OUTPUT_DESTINATION>"
    exit 1
fi

THEMES_SOURCE="$1"
IOS_OUTPUT_DESTINATION="$2"
ANDROID_OUTPUT_DESTINATION="$3"
SCRIPT_DIRECTORY="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
THEMES_DIRECTORY="$SCRIPT_DIRECTORY/StyleDictionary/themes"

if [ ! -d "$THEMES_SOURCE" ]; then
    echo "Error: Source themes directory '$THEMES_SOURCE' does not exist."
    exit 1
fi

rm -rf "$THEMES_DIRECTORY"
mkdir -p "$THEMES_DIRECTORY"
cp -r "$THEMES_SOURCE"/. "$THEMES_DIRECTORY"/

npm --prefix "$SCRIPT_DIRECTORY/StyleDictionary" install
npm --prefix "$SCRIPT_DIRECTORY/StyleDictionary" run build

cp -r "$SCRIPT_DIRECTORY/StyleDictionary/build/ios/SDThemer.swift" "$IOS_OUTPUT_DESTINATION"
cp -r "$SCRIPT_DIRECTORY/StyleDictionary/build/android/SDThemer.kt" "$ANDROID_OUTPUT_DESTINATION"
