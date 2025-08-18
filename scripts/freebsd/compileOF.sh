#!/usr/local/bin/bash

export LC_ALL=C

ARCH=$(uname -m)
if [ "$ARCH" = "amd64" ]; then
        LIBSPATH=freebsd
else
        LIBSPATH=freevbsd32
fi

pushd `dirname $0` > /dev/null
SCRIPTPATH="$(pwd)"
popd > /dev/null

BUILD="install"
JOBS=1
while getopts tj: opt ; do
	case "$opt" in
		t)  # testing, only build Debug
		    BUILD="test" ;;
		j)  # make job count for parallel build
		    JOBS="$OPTARG"
	esac
done

cd "${SCRIPTPATH}/../../libs/openFrameworksCompiled/project"
gmake -j$JOBS Debug
exit_code=$?
if [ $exit_code != 0 ]; then
  echo "there has been a problem compiling Debug OF library"
  echo "please report this problem in the forums"
  exit $exit_code
fi

if [ "$BUILD" == "install" ]; then
    gmake -j$JOBS Release
    exit_code=$?
    if [ $exit_code != 0 ]; then
      echo "there has been a problem compiling Release OF library"
      echo "please report this problem in the forums"
      exit $exit_code
    fi
fi
