#!/bin/bash -e

. ../../include/depinfo.sh
. ../../include/path.sh
build=_build$ndk_suffix

if [ "$1" == "build" ]; then
    true
elif [ "$1" == "clean" ]; then
    rm -rf $build
    rm -rf build
    exit 0
else
    exit 255
fi

# Always clean before building
$0 clean

# Create build directory
mkdir -p $build



# 日志函数
log() {
    echo "[zimg] $1"
}

# 错误处理函数
error() {
    log "Error: $1"
    exit 1
}

# 打印环境变量
print_env_vars() {
    log "Environment variables:"
    log "ANDROID_NDK: $ANDROID_NDK"
    log "TOOLCHAIN: $TOOLCHAIN"
    log "CC: $CC"
    log "CXX: $CXX"
    log "AR: $AR"
    log "RANLIB: $RANLIB"
    log "android_abi: $ANDROID_ABI"
    log "android_api: $ANDROID_NATIVE_API_LEVEL"
    log "prefix_dir: $prefix_dir"
    log "cores: $cores"
    log "pwd: $(pwd)"
}

export PKG_CONFIG_PATH="$prefix_dir/usr/lib/pkgconfig"
export PKG_CONFIG_LIBDIR="$prefix_dir/usr/lib/pkgconfig"

# Configure with CMake

print_env_vars

./autogen.sh
cd $build

../configure \
    CC="$CC" \
    CXX="$CXX" \
    AR="$AR" \
    RANLIB="$RANLIB" \
    LD="$LD" \
    CFLAGS="-O2" \
    CXXFLAGS="-O2" \
    KG_CONFIG_PATH="$prefix_dir/usr/lib/pkgconfig" \
    PKG_CONFIG_LIBDIR="$prefix_dir/usr/lib/pkgconfig" \
    --prefix="$prefix_dir" \
    --host="$ndk_triple" \
    --with-sysroot="$ANDROID_NDK/sysroot" \
    --disable-shared \
    --disable-tests \
    --disable-examples



log "Building"
make -j$cores VERBOSE=1 || error "Build failed"

log "Installing"
make install || error "Installation failed"


# Generate pkg-config file
log "Generating pkg-config file"

mkdir -p $prefix_dir/lib/pkgconfig
cat > $prefix_dir/lib/pkgconfig/zimg.pc << EOF
prefix=/usr
exec_prefix=${prefix_dir}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: zimg
Description: Google zimg
Version: 3.0.5
Libs: -L\${libdir} -lzimg
Cflags: -I\${includedir}
EOF