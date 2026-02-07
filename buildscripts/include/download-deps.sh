#!/bin/bash -e

. ./include/depinfo.sh

[ -z "$WGET" ] && WGET=wget

mkdir -p deps && cd deps

# mbedtls

[ ! -d mbedtls ] && git clone --depth 1 --branch v$v_mbedtls --recurse-submodules https://github.com/Mbed-TLS/mbedtls.git mbedtls

# dav1d
[ ! -d dav1d ] && git clone --depth 1 --branch $v_dav1d https://code.videolan.org/videolan/dav1d.git dav1d


# libxml2
[ ! -d libxml2 ] && git clone --depth 1 --branch v$v_libxml2 --recursive https://gitlab.gnome.org/GNOME/libxml2.git libxml2

# ffmpeg
[ ! -d ffmpeg ] && git clone --depth 1 --branch n$v_ffmpeg https://github.com/FFmpeg/FFmpeg.git ffmpeg

# freetype2
[ ! -d freetype ] && git clone --depth 1 --branch VER-$v_freetype https://gitlab.freedesktop.org/freetype/freetype.git freetype

# fribidi
[ ! -d fribidi ] && git clone --depth 1 --branch v$v_fribidi https://github.com/fribidi/fribidi.git fribidi

# harfbuzz
[ ! -d harfbuzz ] && git clone --depth 1 --branch $v_harfbuzz https://github.com/harfbuzz/harfbuzz.git harfbuzz

# libass
[ ! -d libass ] && git clone --depth 1 --branch $v_libass https://github.com/libass/libass.git libass

# lua
if [ ! -d lua ]; then
	mkdir lua
	$WGET http://www.lua.org/ftp/lua-$v_lua.tar.gz -O - | \
		tar -xz -C lua --strip-components=1
fi

# lcms2
[ ! -d lcms2 ] && git clone --recursive --depth 1 --branch lcms2.16 https://github.com/mm2/Little-CMS.git lcms2

[ ! -d libbluray ] && git clone  --depth 1 --branch $v_libbluray --recursive https://code.videolan.org/videolan/libbluray.git libbluray

[ ! -d libdvdread ] && git clone  --depth 1 --branch $v_libdvdread --recursive https://code.videolan.org/videolan/libdvdread.git libdvdread

[ ! -d libdvdnav ] && git clone  --depth 1 --branch $v_libdvdnav --recursive https://code.videolan.org/videolan/libdvdnav.git libdvdnav

#[ ! -d mpvshaderc ] && git clone  --depth 1 --branch master --recursive https://github.com/rorgoroth/mpv-shaderc.git mpvshaderc

#[ ! -d shaderc ] && git clone  --depth 1 --branch v$v_shaderc --recursive https://github.com/google/shaderc.git shaderc

#[ ! -d zimg ] && git clone  --depth 1 --branch release-3.0.5 --recursive https://github.com/sekrit-twc/zimg.git zimg


#[ ! -d vapoursynth ] && git clone  --depth 1 --branch $v_vapoursynth --recursive https://github.com/vapoursynth/vapoursynth.git vapoursynth


#[ ! -d spirv_headers ] && git clone  --depth 1 --branch $v_spirv_headers --recursive https://github.com/KhronosGroup/SPIRV-Headers.git spirv_headers


#[ ! -d spirv_tools ] && git clone  --depth 1 --branch $v_spirv_tools --recursive https://github.com/KhronosGroup/SPIRV-Tools.git spirv_tools


#[ ! -d spirv_cross ] && git clone  --depth 1 --branch $v_spirv_cross --recursive https://github.com/KhronosGroup/SPIRV-Cross.git spirv_cross

#[ ! -d uchardet ] && wget https://www.freedesktop.org/software/uchardet/releases/uchardet-0.0.8.tar.xz && tar Jxf uchardet-0.0.8.tar.xz && mv uchardet-0.0.8 uchardet && rm -f uchardet-0.0.8.tar.xz


[ ! -d libplacebo ] && git clone --depth 1 --branch v$v_libplacebo --recursive https://code.videolan.org/videolan/libplacebo.git libplacebo


# mpv
[ ! -d mpv ] && git clone --depth 1 --branch v$v_mpv https://github.com/mpv-player/mpv.git mpv


# sentry-native
#[ ! -d sentry-native ] && git clone --recursive --depth 1 --branch 0.7.6 https://github.com/getsentry/sentry-native.git sentry-native


# media-kit-android-helper
[ ! -d media-kit-android-helper ] && git clone --depth 1 --branch main https://github.com/media-kit/media-kit-android-helper.git

# media_kit
[ ! -d media_kit ] && git clone --depth 1 --single-branch --branch main https://github.com/alexmercerind/media_kit.git


cd ..
