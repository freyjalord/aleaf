#!/bin/bash

BASE=`dirname "$0"`
HOST_OS=`uname -s | tr "[:upper:]" "[:lower:]"`
HOST_ARCH=`uname -m | tr "[:upper:]" "[:lower:]"`

export PATH="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin/":$PATH
android_tools="$NDK_HOME/toolchains/llvm/prebuilt/$HOST_OS-$HOST_ARCH/bin"
api=26

for target in x86_64-linux-android aarch64-linux-android armv7-linux-androideabi i686-linux-android; do
    case $target in
        'x86_64-linux-android')
            export CC_x86_64_linux_android="$android_tools/${target}${api}-clang"
            export AR_x86_64_linux_android="$android_tools/llvm-ar"
            export CARGO_TARGET_X86_64_LINUX_ANDROID_AR="$android_tools/llvm-ar"
            export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER="$android_tools/${target}${api}-clang"
            mkdir -p "$BASE/../../jniLibs/x86_64/"
			cargo build --target $target --manifest-path "$BASE/Cargo.toml" --no-default-features --features "leaf/default-ring" --release
			cp "$BASE/target/$target/release/libleafandroid.so" "$BASE/../../jniLibs/x86_64/"
            ;;
        'aarch64-linux-android')
            export CC_aarch64_linux_android="$android_tools/${target}${api}-clang"
            export AR_aarch64_linux_android="$android_tools/llvm-ar"
            export CARGO_TARGET_AARCH64_LINUX_ANDROID_AR="$android_tools/llvm-ar"
            export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER="$android_tools/${target}${api}-clang"
            mkdir -p "$BASE/../../jniLibs/arm64-v8a/"
			cargo build --target $target --manifest-path "$BASE/Cargo.toml" --no-default-features --features "leaf/default-ring" --release
			cp "$BASE/target/$target/release/libleafandroid.so" "$BASE/../../jniLibs/arm64-v8a/"
			;;
        'armv7-linux-androideabi')
            export CC_armv7_linux_androideabi="$android_tools/armv7a-linux-androideabi${api}-clang"
            export AR_armv7_linux_androideabi="$android_tools/llvm-ar"
            export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_AR="$android_tools/llvm-ar"
            export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER="$android_tools/armv7a-linux-androideabi${api}-clang"
            mkdir -p "$BASE/../../jniLibs/armeabi-v7a/"
			cargo build --target $target --manifest-path "$BASE/Cargo.toml" --no-default-features --features "leaf/default-ring" --release
			cp "$BASE/target/$target/release/libleafandroid.so" "$BASE/../../jniLibs/armeabi-v7a/"
			;;
        'i686-linux-android')
            export CC_i686_linux_android="$android_tools/${target}${api}-clang"
            export AR_i686_linux_android="$android_tools/llvm-ar"
            export CARGO_TARGET_I686_LINUX_ANDROID_AR="$android_tools/llvm-ar"
            export CARGO_TARGET_I686_LINUX_ANDROID_LINKER="$android_tools/${target}${api}-clang"
            mkdir -p "$BASE/../../jniLibs/x86/"
			cargo build --target $target --manifest-path "$BASE/Cargo.toml" --no-default-features --features "leaf/default-ring" --release
			cp "$BASE/target/$target/release/libleafandroid.so" "$BASE/../../jniLibs/x86/"
            ;;
        *)
            echo "Unknown target $target"
            ;;
    esac
done
