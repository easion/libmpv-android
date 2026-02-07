#!/bin/bash -e

## Dependency versions

v_platform=android-36
v_sdk=11076708_latest
v_ndk=r29
v_ndk_n=29.0.14206865
v_sdk_platform=35
v_sdk_build_tools=36.0.0
v_cmake=4.0.2

v_lua=5.2.4
v_libass=0.17.4
#v_harfbuzz=9.0.0
v_harfbuzz=12.2.0
v_fribidi=1.0.16
v_freetype=2-14-1

v_mbedtls=3.6.5
#v_libplacebo=6.338.2
v_libplacebo=7.351.0
v_dav1d=1.5.1
#v_ffmpeg=7.1.1
v_ffmpeg=8.0
v_lcms2=lcms2.16
v_mpv=0.41.0

v_libxml2=2.10.3
v_libbluray=1.4.1
v_libdvdnav=7.0.0
v_libdvdread=7.0.1
#v_libdvdread=master
v_shaderc=2024.1
v_vapoursynth=R69
v_spirv_cross=vulkan-sdk-1.3.283.0
v_spirv_headers=vulkan-sdk-1.3.283.0
v_spirv_tools=vulkan-sdk-1.3.283.0

## Dependency tree
# I would've used a dict but putting arrays in a dict is not a thing

dep_mbedtls=()
dep_dav1d=()
dep_ffmpeg=(mbedtls dav1d libxml2)
dep_freetype=()
dep_fribidi=()
dep_harfbuzz=(freetype)
dep_libass=(freetype fribidi harfbuzz)
dep_lua=()
dep_vapoursynth=(zimg)
dep_mpvshaderc=()
# dep_shaderc=(spirv_cross spirv_headers spirv_tools)
#dep_libplacebo=(lcms2 mpvshaderc)
dep_libplacebo=(lcms2)
dep_libbluray=(libdvdread libdvdnav)
# dep_mpv=(ffmpeg libass lua uchardet mpvshaderc vapoursynth spirv_cross libbluray libdvdnav libplacebo)
dep_mpv=(ffmpeg libass lua libbluray  libplacebo)
dep_mpv_android=(mpv)

