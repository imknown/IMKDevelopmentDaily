- Xfce  
http://www.xfce.org/

安装:
``` bash
sudo apt-get update
sudo apt-get install xfce4
sudo apt-get install xubuntu-desktop # 可选, 推荐, 可以使用 更多面板
```

卸载参考:
```
sudo apt-get purge xfconf xfce4-utils xfwm4 xfce4-session thunar xfdesktop4 exo-utils xfce4-panel xfce4-terminal libxfce4util-common scim xscreensaver
sudo apt-get purge *xubuntu*
sudo apt-get purge *xfce4*
```
http://askubuntu.com/questions/574481/how-can-i-install-xfce-and-completely-remove-unity
http://askubuntu.com/questions/530757/removing-xubuntu-from-ubuntu-14-04

- LXDE  
https://wiki.lxde.org/en/Installation#Instructions_for_Ubuntu.2FDebian_.28APT.29
``` bash
sudo apt-get update
sudo apt-get install lxde
sudo apt-get install lubuntu-core lubuntu-icon-theme lubuntu-restricted-extras # 可选, 推荐
```

- Cinnamon  
http://developer.linuxmint.com/projects.html
``` bash
sudo add-apt-repository ppa:gwendal-lebihan-dev/cinnamon-stable
sudo apt-get update
sudo apt-get install cinnamon
```

- MATE  
http://wiki.mate-desktop.org/download#ubuntu
``` bash
sudo add-apt-repository "deb http://packages.mate-desktop.org/repo/ubuntu precise main"

sudo apt-get update
sudo apt-get --yes --quiet --allow-unauthenticated install mate-archive-keyring
sudo apt-get update

# You need only choose one of the apt-get options below.
# [1] This will install the base packages required for a minimal MATE desktop
sudo apt-get install mate-core
# [2] This will install the complete MATE desktop
sudo apt-get install mate-desktop-environment
```

- KDE/Kubuntu Plasma (不太推荐, 太重)  
https://www.kde.org/download/
``` bash
sudo add-apt-repository ppa:kubuntu-ppa/backports
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install kubuntu-desktop
```

参考:  
http://www.tecmint.com/install-kde-plasma-5-in-linux/
