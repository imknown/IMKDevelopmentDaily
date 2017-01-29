`神船笔记本` 蓝光 太重了, 没法忍,  
又没有 windows 下的 intel 驱动控制色温,  
而且 `XFCE 桌面环境` 本身并不支持 像 `Ubuntu gnome` 自由调整色温:  
> https://wiki.archlinux.org/index.php/Xfce#Colour_management

所以折疼了一下 `RedShift`:
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

然后 可以手动配置一下 `~/.config/redshift.conf`, 如:
``` ini
[redshift]
temp-day=5700
temp-night=4000

transition=1
```
具体用法 参考 官网 http://jonls.dk/redshift/#configuration-file .  

#### 参考
- https://en.wikipedia.org/wiki/Redshift_(software)
- https://github.com/jonls/redshift

#### 尝试过的其他方式
效果只能维持几秒, 所以放弃了:  
http://askubuntu.com/questions/199661/how-do-you-set-system-display-color-profiles-in-xubuntu-and-lubuntu
