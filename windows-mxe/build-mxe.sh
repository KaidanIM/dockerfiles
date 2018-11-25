#!/bin/bash

export MXE_ROOT="$(readlink -f $PWD)/mxe"
mkdir -p $MXE_ROOT

git clone https://github.com/mxe/mxe $MXE_ROOT

echo "- Building required MXE packages ..."
make -C $MXE_ROOT \
	MXE_TARGETS="x86_64-w64-mingw32.static" \
	qtbase \
	qtdeclarative \
	qtquickcontrols2 \
	qtgraphicaleffects \
	qttools \
	cc \
	binutils \
	--jobs=$(nproc)

echo "- Replacing absolute with relative pathes"
for file in $(find $MXE_ROOT/usr/); do
	if [ ! -z "$(file $file | awk -F: '/ASCII text/ {print $1}')" ]; then
		sed -i "s|$MXE_ROOT|\$MXE_ROOT|g" $file
	fi
done
