#!/bin/sh
# fwu-shredder by InvisiBot: https://github.com/InvisiBot/fwu-shredder.git
# My profile on 4PDA: http://4pda.ru/forum/index.php?showuser=2670695
# My profile on XDA: https://forum.xda-developers.com/member.php?u=7031497
# This shell script cuts the file fwu_image.bin (from update.zip) into the components of the firmware for Intel Atom x3 SoFIA.
# This shell script depends on the utilities: basename, hexdump, cut, grep, dd
# How to use:
# wget https://raw.githubusercontent.com/InvisiBot/fwu-shredder/master/fwu-shredder.sh
# chmod 755 fwu-shredder.sh
# ./fwu-shredder.sh fwu_image.bin
# or:
# sh fwu-shredder.sh fwu_image.bin
# The result is a directory "extracted-fwu_image.bin" containing the files.


if [ ! "$1" -o ! -f "$1" ]; then
	echo "No fwu_image.bin file supplied.";
	exit 1;
fi;

idbd() {
	case $1 in
		123) file_name="vrl.bin";;
		0) file_name="psi_flash.bin";;
		16) file_name="slb.bin";;
		113) file_name="ucode_patch.bin";;
		13) file_name="splash_img.bin";;
		115) file_name="mvconfig_smp.bin";;
		1) file_name="mobilevisor.bin";;
		118) file_name="secvm.bin";;
		71) file_name="boot.bin";;
		121) file_name="recovery.bin";;
#		114) file_name="radio.bin";;
#		68) file_name="system.bin";;
#		69) file_name="data.bin";;
#		70) file_name="cache.bin";;
		*) echo "Done.\nFiles extracted from \n$fwu_file \nare located in:\n$PWD/$dir"; echo; exit;;
	esac;
}

fwu_file=$1

dir=extracted-$(basename $fwu_file)

mkdir -p $dir

table=$(hexdump -n 512 -e '4/4 "%d " "\n"' $fwu_file | cut -d ' ' -f 1,3- | grep -A 13 123)

temp=$IFS

IFS="
"

for str in $table; do
	IFS=$temp
		set $str
		id=$1
		offset=$(($2 * 512))
		length=$3
	idbd $id
	echo $file_name ":" "offset:"$offset "length:"$length;
dd if=$fwu_file skip=1 ibs=$offset obs=$length | dd bs=$length count=1 of=$dir/$file_name
	echo
done


exit 0
