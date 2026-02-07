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
cd $build


# 日志函数
log() {
    echo "[sentry-native] $1"
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


# Configure with CMake

print_env_vars

cmake .. \
    -DCMAKE_C_COMPILER="$CC" \
    -DCMAKE_CXX_COMPILER="$CXX" \
    -DCMAKE_AR="$(type -p $AR)" \
    -DCMAKE_RANLIB="$(type -p $RANLIB)" \
    -DCMAKE_LINKER="$(type -p $LD)" \
    -DCMAKE_BUILD_TYPE=Release \
    -DSENTRY_BUILD_SHARED_LIBS=ON \
    -DSENTRY_BUILD_TESTS=OFF \
    -DSENTRY_BUILD_EXAMPLES=OFF \
    -DCMAKE_INSTALL_PREFIX="$prefix_dir" \
    -DANDROID_ABI="$ANDROID_ABI" \
    -DANDROID_NATIVE_API_LEVEL="$ANDROID_NATIVE_API_LEVEL" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DANDROID_TOOLCHAIN=clang


log "Building"
make -j$cores VERBOSE=1 || error "Build failed"

log "Installing"
make install || error "Installation failed"

# ln -sf "$prefix_dir"/lib/libsentry.so "$native_dir"

# Generate pkg-config file
log "Generating pkg-config file"

mkdir -p $prefix_dir/lib/pkgconfig
cat > $prefix_dir/lib/pkgconfig/sentry.pc << EOF
prefix=${prefix_dir}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: sentry
Description: Sentry Native SDK
Version: ${SENTRY_VERSION}
Libs: -L\${libdir} -lsentry
Cflags: -I\${includedir}
EOF