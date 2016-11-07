`XFCE 桌面环境` 本身并不支持 像 `Ubuntu gnome` 自由调整色温:  
> https://wiki.archlinux.org/index.php/Xfce#Colour_management

所以尝试一下 `RedShift`:
> http://jonls.dk/redshift/


安装方法:  
http://askubuntu.com/questions/482373/how-do-i-install-redshift-in-ubuntu
``` bash
sudo apt install redshift redshift-gtk
```

然后 启用, 通知区域的图标 右键, 勾选 autostart 即可
``` bash
redshift-gtk
或者
gtk-redshift
```

具体用法 参考 官网.  

#### 参考
- https://en.wikipedia.org/wiki/Redshift_(software)
- https://github.com/jonls/redshift

#### 尝试过的其他方式
效果只能维持几秒, 所以放弃了:  
http://askubuntu.com/questions/199661/how-do-you-set-system-display-color-profiles-in-xubuntu-and-lubuntu
