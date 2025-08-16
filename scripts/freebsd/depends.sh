#!/bin/sh
sudo pkg install -y git gmake pkgconf cairo gstreamer1-plugins libudev-devd libsndfile \
openal-soft pulseaudio alsa-lib libglvnd libGLU glew freeimage uriparser rtaudio glfw freeglut \
pugixml v4l_compat premake5 cmake bash
./../dev/download_libs.sh -p linux -a 64gcc6
git clone https://github.com/memononen/libtess2
cp premake5.lua libtess2 && cd libtess2 && premake5 --cc=clang --os=bsd gmake && cd Build && gmake && cp libtess2.a ../../../../libs/tess2/lib/linux64/libtess2.a
cd ../../../../scripts/freebsd
git clone https://github.com/mborgerding/kissfft.git
cd kissfft
patch < ../patch_kissfft_cmake.patch
mkdir -p build && cd build && cmake -DKISSFFT_STATIC="ON" -DKISSFFT_INSTALL_CMAKE=./ -DCMAKE_INSTALL_PREFIX=./ -DCMAKE_INSTALL_INCLUDEDIR=./../../../../libs/kiss/include/include/kissfft/ -DCMAKE_INSTALL_LIBDIR=./../../../../libs/kiss/lib/linux64 .. && make && make install
cd ../../../../scripts/freebsd
cp ../../libs/kiss/lib/linux64/libkissfft-float.a ../../libs/kiss/lib/linux64/libkiss.a


