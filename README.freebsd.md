t clone https://github.com/jsm222/openFrameworks
 git checkout fbsd-support
 cat openFrameworks/.gitmodules
[submodule "apps/projectGenerator"]
    path = apps/projectGenerator
    url = https://github.com/jsm222/projectGenerator
    branch = fbsd-support
[submodule "scripts/apothecary"]
    path = scripts/apothecary
    url = https://github.com/jsm222/apothecary
    branch = fbsd-support1
git submodule sync
git submodule update --init --remote
pkg install cairo gstreamer1-plugins libudev-devd libsndfile \
openal-soft pulseaudio alsa-lib libglvnd libGLU glew freeimage uriparser rtaudio glfw freeglut \
pugixml v4l_compat cmake bash assimp opencv cmake gmake findutils


cd openFrameworks/scripts/apothecary/scripts/freebsd ./build_freebsdamd64.sh 
cd openFrameworks/scripts/apothecary/out
cp -av * ../../../libs/
cd openFrameworks/scripts/apothecary/scripts/freebsd
./compileOF.sh -j `sysctl -n hw.ncpu`
./compilePF.sh -j `sysctl -n hw.ncpu`
cd openFrameworks/scripts/apothecary/scripts/freebsd
./buildAllExamples.sh
