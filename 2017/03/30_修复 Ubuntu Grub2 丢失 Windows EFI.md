手动感谢 @lrinQVQ.

### 手动查看信息
`/boot/grub/grub.cfg` 这个文件 会在 `sudo update-grub2` 之后覆写.  
覆写的依据是 `/etc/grub.d` 中 若干文件 (参看 `/etc/grub.d/README`).
> cat /boot/grub/grub.cfg
> fdisk -l

备份一下 我的**正确** `Windows 10` 引导:
``` cfg
### BEGIN /etc/grub.d/30_os-prober ###
menuentry 'Windows Boot Manager (on /dev/sdb2)' --class windows --class os $menuentry_id_option 'osprober-efi-A2BB-769D' {
	insmod part_gpt
	insmod fat
	set root='hd1,gpt2'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd1,gpt2 --hint-efi=hd1,gpt2 --hint-baremetal=ahci1,gpt2  A2BB-769D
	else
	  search --no-floppy --fs-uuid --set=root A2BB-769D
	fi
	chainloader /efi/Microsoft/Boot/bootmgfw.efi
}
set timeout_style=menu
if [ "${timeout}" = 0 ]; then
  set timeout=10
fi
### END /etc/grub.d/30_os-prober ###
```

### 给力的图形工具:
- Boot-Repair https://help.ubuntu.com/community/Boot-Repair
- gparted https://help.ubuntu.com/community/GParted

### 术语参考
- https://technet.microsoft.com/en-us/library/dn336950.aspx
- https://technet.microsoft.com/en-us/library/85cd5efe-c349-427c-b035-c2719d4af778
- https://help.ubuntu.com/community/UEFIBooting
- http://www.dell.com/support/article/cn/zh/cnbsdt1/SLN288647/dell-optiplex3020%E7%B3%BB%E7%BB%9F%E6%8C%87%E5%8D%97--?lang=ZH (操作系统-安装和驱动程序)

### 给了我思路的文章
- http://www.jianshu.com/p/a57e35e9ebe8
- http://www.linuxidc.com/Linux/2012-11/74901.htm
- http://blog.sina.com.cn/s/blog_53ed87c101018tr2.html
- http://blog.sina.com.cn/s/blog_59eff7510100ztgf.html
