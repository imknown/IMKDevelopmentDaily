今天装回了 `ubuntu 16.04.1`, 唉，  
比 `麒麟 16` 和 `ubuntu 14.04` 强好多啊。  

# WeChat 安装
- 原生 微信  
https://github.com/geeeeeeeeek/electronic-wechat/releases  

# QQ 安装
### 建议先安装 Wine, 虽然 Ubuntu 自带
[Ubuntu Wine 安装总结.md](https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/10/03_Ubuntu%20Wine%20%E5%AE%89%E8%A3%85%E6%80%BB%E7%BB%93.md)


- Longene Wine QQ 7.8 (推荐, 可自动升级到最新版)  
http://www.longene.org/forum/viewtopic.php?f=6&t=30516  

- Wine QQ 国际版 2012 (不推荐)  
http://www.ubuntukylin.com/application/show.php?lang=cn&id=279  

- 2016-10-24: ubuntu 16.04 完美运行新版QQ方案  
https://www.so-cools.com/?p=739

- 2017-03-07: 清风 QQ 和 Deepin QQ
 - http://phpcj.org/wineqq/
 - http://www.findspace.name/easycoding/1748

# 卸载 Wine QQ  
http://www.cnblogs.com/exmyth/p/4066090.html  

# 64位 Ubuntu 无法启动 QQ
尝试 安装 32位 库:
``` bash
dpkg --add-architecture i386
apt-get install libgtk3.0-0:i386
# 或者
apt-get install libgtk2.0-0:i386
```
参考: http://blog.csdn.net/cwll2009/article/details/24449893  

# QQ 不能输入中文的问题
用 sudo 打开:  
- 国际版
> /usr/share/deepinwine/qqintl/wine-qqintl  
> 或  
> /usr/bin/wine-qqintl

- Longene 版
> /opt/longene/qq/qq.sh

在 `export LANG=zh_CN.utf8` 下面加上:
``` properties
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
```
保存, 然后重启 `QQ` 即可.

# 替换字体 (有待复测)
替换同名文件即可, 我用的 `Win10 微软雅黑`,  
个别地方 显示成 方块儿, 但是可以忍 :D
> ~/.longene/qq/drive_c/windows/Fonts/simsun.ttf  

参考:
- http://forum.ubuntu.org.cn/viewtopic.php?p=2669658
- http://www.linuxdiyf.com/linux/18884.html
