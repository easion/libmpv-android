# This file is a part of media_kit (https://github.com/alexmercerind/media_kit).
#
# Copyright © 2021 & onwards, Hitesh Kumar Saini <saini123hitesh@gmail.com>.
# All rights reserved.
# Use of this source code is governed by MIT license that can be found in the LICENSE file.

cmake_minimum_required(VERSION 3.22.1)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project("mediakitandroidhelper")

find_library(log-lib log)
find_library(android-lib android)

add_library(mediakitandroidhelper SHARED native-lib.cpp)

target_link_libraries(
        mediakitandroidhelper
        ${log-lib}
        ${android-lib}
)

#add_library(media_kit_native_event_loop SHARED media_kit_native_event_loop.cpp)

add_library(
        mpv
        SHARED
        IMPORTED
)

set_target_properties(
        mpv
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/libmpv.so
)

include_directories( ${CMAKE_CURRENT_SOURCE_DIR}/../../../../buildscripts/prefix/${ANDROID_ABI}/include )



#target_link_libraries(
#        media_kit_native_event_loop
#        mpv log
#)


