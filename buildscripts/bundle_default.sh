#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD="$DIR/"

. $BUILD/include/path.sh
. $BUILD/include/depinfo.sh

clear
echo "BUILD=${BUILD}"
# --------------------------------------------------

cd deps/media-kit-android-helper

sudo chmod +x gradlew
./gradlew assembleRelease

unzip -o app/build/outputs/apk/release/app-release.apk -d app/build/outputs/apk/release

cp app/build/outputs/apk/release/lib/arm64-v8a/libmediakitandroidhelper.so      ../../prefix/arm64-v8a/usr/local/lib
cp app/build/outputs/apk/release/lib/armeabi-v7a/libmediakitandroidhelper.so    ../../prefix/armeabi-v7a/usr/local/lib
cp app/build/outputs/apk/release/lib/x86/libmediakitandroidhelper.so            ../../prefix/x86/usr/local/lib
cp app/build/outputs/apk/release/lib/x86_64/libmediakitandroidhelper.so         ../../prefix/x86_64/usr/local/lib

cd ../..

zip -r default-arm64-v8a.jar                prefix/arm64-v8a/usr/local/lib/*.so
zip -r default-armeabi-v7a.jar              prefix/armeabi-v7a/usr/local/lib/*.so
zip -r default-x86.jar                      prefix/x86/usr/local/lib/*.so
zip -r default-x86_64.jar                   prefix/x86_64/usr/local/lib/*.so

md5sum *.jar
