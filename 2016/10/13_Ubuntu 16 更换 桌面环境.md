- Xfce  
http://www.xfce.org/
``` bash
# sudo apt-get install xubuntu-desktop # 可选, 推荐, 可以使用 更多面板
sudo apt-get update
sudo apt-get install xfce4
```
参考:  
http://askubuntu.com/questions/574481/how-can-i-install-xfce-and-completely-remove-unity

- lxde  
https://wiki.lxde.org/en/Installation#Instructions_for_Ubuntu.2FDebian_.28APT.29
``` bash
sudo apt-get install lxde
```

- cinnamon  
http://developer.linuxmint.com/projects.html
``` bash
# sudo add-apt-repository ppa:gwendal-lebihan-dev/cinnamon-stable # 这句话 是否要写, 有待测试
sudo apt-get update
sudo apt install cinnamon
```

- KDE/Kubuntu Plasma (不太推荐, 太重)  
https://www.kde.org/download/
``` bash
# sudo add-apt-repository ppa:kubuntu-ppa/backports # 这句话 是否要写, 有待测试
sudo apt-get update && sudo apt-get dist-upgrade
sudo apt-get install kubuntu-desktop
```

参考:  
http://www.tecmint.com/install-kde-plasma-5-in-linux/
