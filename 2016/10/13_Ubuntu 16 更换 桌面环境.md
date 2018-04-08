# XFCE
- http://www.xfce.org/
- http://askubuntu.com/questions/574481/how-can-i-install-xfce-and-completely-remove-unity

### 最小安装
``` bash
sudo apt-get update
sudo apt-get install xfce4
```

### 完整安装
``` bash
sudo apt-get update
sudo apt-get install xubuntu-desktop
```

### 卸载参考
- http://askubuntu.com/questions/530757/removing-xubuntu-from-ubuntu-14-04

```
sudo apt-get purge xfconf xfce4-utils xfwm4 xfce4-session thunar xfdesktop4 exo-utils xfce4-panel xfce4-terminal libxfce4util-common scim xscreensaver
sudo apt-get purge *xubuntu*
sudo apt-get purge *xfce4*
```


# KDE/Plasma
- https://www.kde.org/plasma-desktop
- https://askubuntu.com/questions/417/how-do-i-install-kde

### 最小安装
``` bash
sudo apt-get install plasma-desktop
```

### 完整安装
``` bash
sudo apt-get install kubuntu-desktop
```


# LXDE
- https://wiki.lxde.org/en/Installation#Instructions_for_Ubuntu.2FDebian_.28APT.29

### 最小安装
``` bash
sudo apt-get update
sudo apt-get install lxde
```

### 完整安装
``` bash
sudo apt-get install lubuntu-core lubuntu-icon-theme lubuntu-restricted-extras
```


# MATE
- http://wiki.mate-desktop.org/download#ubuntu

### 最小安装
``` bash
sudo apt-get update
sudo apt-get install mate-desktop-environment-core
```

### 完整安装
``` bash
sudo apt-get install mate-desktop-environment
```

### 更完整的安装
``` bash
sudo apt-get install mate-desktop-environment-extras
```

### Ubuntu Mate: 超完整的安装
```
sudo apt-get update
sudo apt-get install ubuntu-mate-core ubuntu-mate-desktop
```


# Cinnamon
- https://github.com/linuxmint/Cinnamon

``` bash
sudo add-apt-repository ppa:gwendal-lebihan-dev/cinnamon-stable
sudo apt-get update
sudo apt-get install cinnamon
```


----

参考:  
- http://www.tecmint.com/install-kde-plasma-5-in-linux/
