fwu-shredder by ***InvisiBot***: https://github.com/InvisiBot/fwu-shredder.git

My profile on ***4PDA***: http://4pda.ru/forum/index.php?showuser=2670695

My profile on ***XDA***: https://forum.xda-developers.com/member.php?u=7031497

This shell script cuts the file **fwu_image.bin** (from **update.zip**) into the components of the firmware for ***Intel Atom x3 SoFIA***.

***This shell script depends on the utilities:*** `basename, hexdump, cut, grep, dd`

## How to use:
    wget https://raw.githubusercontent.com/InvisiBot/fwu-shredder/master/fwu-shredder.sh

    chmod 755 fwu-shredder.sh

    ./fwu-shredder.sh fwu_image.bin
or

    sh fwu-shredder.sh fwu_image.bin

The result is a directory **extracted-fwu_image.bin** containing the files:

    vrl.bin

    psi_flash.bin

    slb.bin

    ucode_patch.bin

    splash_img.bin

    mvconfig_smp.bin

    mobilevisor.bin

    secvm.bin

    boot.bin

    recovery.bin

These files can be flashed to the device via **fastboot**:

    fastboot oem unlock
		
    fastboot oem unlock confirm
		

    fastboot flash vrl vrl.bin
		
    fastboot flash psi psi_flash.bin
		
    fastboot flash slb slb.bin
		
    fastboot flash ucode_patch ucode_patch.bin
		
    fastboot flash hypervisor mobilevisor.bin
		
    fastboot flash mvconfig mvconfig_smp.bin
		
    fastboot flash secvm secvm.bin
		
    fastboot flash splash splash_img.bin
		
    fastboot flash boot boot.bin
		
    fastboot flash recovery recovery.bin
		

    fastboot flash system system.bin
		
    fastboot flash userdata userdata.bin
		
    fastboot flash cache cache.bin


