#!/bin/sh

export LC_ALL=C
gmake -j `sysctl -n hw.ncpu` -C ../../examples
