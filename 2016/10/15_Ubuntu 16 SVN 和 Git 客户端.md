承接上文:  
https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/09/28_Ubuntu%2016%20%E5%AE%89%E8%A3%85%20RabbitVCS.md

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

#### 此外, 小兔子 可以考虑一下...
http://wiki.rabbitvcs.org/wiki/install/ubuntu  

注意:  
- `Gnome` + `Nautilus` 推荐使用 RabbitVCS, 效果不错  
  但是 Git 不能用来 检出 带 身份验证的库 (无语)
- `Xfce` + `Thunar` 比较坑, 效果不佳啊!!

小兔子 如果 nautilus3 或 thunar 装不上, 可以尝试:  
- rabbitvcs-nautilus3  
- thunarx-python  
- rabbitvcs-thunar  

参考: 
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/ppa/+packages
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/rabbitvcs-testing/+build/5648690
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/rabbitvcs-testing/+sourcepub/3947616/+listing-archive-extra
- https://launchpad.net/~nilarimogard/+archive/ubuntu/test/+build/4063999

================= thunarx-python =================
- http://goodies.xfce.org/projects/bindings/thunarx-python
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/ppa
- https://launchpad.net/~rabbitvcs/+archive/ubuntu/rabbitvcs-testing
- https://launchpad.net/ubuntu/+source/rabbitvcs/0.16-1
