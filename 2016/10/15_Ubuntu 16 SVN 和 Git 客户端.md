# SVN
**svn 核心 Ubuntu 自带, 所以不用刻意下载**  

好用的 GUI 工具 RapidSVN:  
http://www.rapidsvn.org/index.php/Main_Page  
``` bash
sudo apt install rapidsvn
``` 

# Git
先要安装:
``` bash
sudo apt install git
```

GUI 工具 Git 官网推荐了几个:  
> https://git-scm.com/download/gui/linux

我比较喜欢 `GitKraken` 和 `git-cola`.

# 此外, 小兔子 可以考虑一下...
http://wiki.rabbitvcs.org/wiki/install/ubuntu  

注意:  
- `Gnome` + `Nautilus` 推荐使用 RabbitVCS, 效果不错  
  但是 Git 不能用来 检出 带 身份验证的库 (无语)
- `Xfce` + `Thunar` 比较坑, 效果不佳啊!!

小兔子 如果 nautilus3 或 thunar 装不上, 可以尝试:  
- rabbitvcs-nautilus3_0.16-1-trusty_all.deb  
- thunarx-python_0.3.0-1-precise_amd64.deb  
- rabbitvcs-thunar_0.16-1-trusty_all.deb  

参考: 
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/ppa/+packages
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/rabbitvcs-testing/+build/5648690
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/rabbitvcs-testing/+sourcepub/3947616/+listing-archive-extra
- https://launchpad.net/~nilarimogard/+archive/ubuntu/test/+build/4063999
