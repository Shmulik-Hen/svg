#!/bin/bash

#set -x

if [ -z $1 ];then
	dirs=$(find . -type d | grep -Ev "git|vscode|tmp|releases" | grep /.*/.*$)

	for dir in $dirs; do
		echo -e "\n$dir"
		pushd $dir >& /dev/null
		files=$(ls *.svg)
		for file in $files; do
			echo -e "\n$file"
			labels=$(grep ^.*id=\".*$ $file | grep -Ev "svg|layer|page|use")
			for label in $labels; do
				label2=$(echo $label | sed -e 's/id=//' -e 's/\"//g' -e 's/>//')
				times=$(grep $label2 $file | wc -l)
				if [ $times = 1 ]; then
					echo $label2
				fi
			done
		done
		popd >& /dev/null
	done
else
	file=$1
	echo -e "\n$file"
	labels=$(grep ^.*id=\".*$ $file | grep -Ev "svg|layer|page|use")
	for label in $labels; do
		label2=$(echo $label | sed -e 's/id=//' -e 's/\"//g' -e 's/>//')
		times=$(grep $label2 $file | wc -l)
		if [ $times = 1 ]; then
			echo $label2
		fi
	done
fi
