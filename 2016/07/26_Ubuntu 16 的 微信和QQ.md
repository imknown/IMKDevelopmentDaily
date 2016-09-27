今天装回了 `ubuntu 16.04.1`, 唉，  
比 `麒麟 16` 和 `ubuntu 14.04` 强好多啊。  

# 安装与卸载
- 原生 微信  
https://github.com/geeeeeeeeek/electronic-wechat/releases  

- Longene Wine QQ 7.8 (推荐)  
http://www.longene.org/forum/viewtopic.php?f=6&t=30516  

- Wine QQ 国际版 2012 (不推荐)  
http://www.ubuntukylin.com/application/show.php?lang=cn&id=279  

- 卸载 Wine QQ  
http://www.cnblogs.com/exmyth/p/4066090.html  

# 不能输入中文的问题
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
