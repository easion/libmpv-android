#!/bin/bash -e

. ../../include/depinfo.sh
. ../../include/path.sh

build=_build$ndk_suffix

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf $build
	exit 0
else
	exit 255
fi

unset CC CXX # meson wants these unset

meson setup $build --cross-file "$prefix_dir"/crossfile.txt \
	--prefer-static --buildtype=debug \
	--default-library shared \
	-Dandroid-media-ndk=enabled \
	-Dlua=enabled \
	-Dlcms2=enabled  \
	-Dvulkan=disabled  \
	-Dlibmpv=true -Dcplayer=false  \
	-Diconv=disabled \
	-Dshaderc=disabled \
	-Dmanpage-build=disabled \
	-Dlibbluray=enabled  \
	-Dzimg=disabled  \
	-Dvapoursynth=disabled  \
	-Degl-angle=disabled  \
	-Drubberband=disabled  \
	-Dspirv-cross=disabled  \
	-Duchardet=disabled  \
	-Ddvdnav=enabled  \
	-Dopenal=disabled  \

#	-Dc_args=-Wno-error=int-conversion

ninja -C $build -j$cores -v

if [ -f $build/libmpv.a ]; then
	echo >&2 "Meson fucked up, forcing rebuild."
	$0 clean
	exec $0 build
fi
DESTDIR="$prefix_dir" ninja -C $build install
echo DESTDIR="$prefix_dir" ninja -C $build install

# ln -sf "$prefix_dir"/lib/libdvnav.so "$native_dir"
