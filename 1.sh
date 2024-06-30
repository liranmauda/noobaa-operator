#!/bin/bash

file1=${1}
file2=${2}

if [ -z ${file1} ]  || [ -z ${file2} ]
then
	echo "2 files must be provided"
	exit 1
fi

is_required=false
while read vendor version x
do
	if [ "${vendor}" == "require" ] 
	then 
		is_required=true
	elif [ "${vendor}" == ")" ]
	then
		is_required=false
        fi

	if ${is_required} 
	then
		read vendor2 version2 x <<< $(grep ${vendor} ${file2})
		if [ ! -z "${x}" ] 
		then
			continue
		fi

                if [ ! -z ${vendor2} ]
		then
			if [ "${version}" != "${version2}" ]
			then
				echo ${vendor} ${version} ${version2}
			fi
		fi
	fi

done < <(cat ${file1})
