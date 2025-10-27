#!/bin/bash
set -x

rdir=$PWD/releases
rm -rf $rdir

dirs=$(ls -l $PWD | awk '/^d/ {print $NF}')

for dir in $dirs; do
	pd=${dir}_presentation
	wd=${rdir}/${pd}
	mkdir -p ${wd}
	cp $PWD/${dir}.html ${wd}/
	tar -C ${dir} -cf - . | tar -C ${wd} -xf -
	pushd ${wd}; zip -rq ${rdir}/${pd}.zip * ; popd
	tar -C ${wd} -zcf ${rdir}/${pd}.tar.gz .
	rm -rf ${wd}
done
