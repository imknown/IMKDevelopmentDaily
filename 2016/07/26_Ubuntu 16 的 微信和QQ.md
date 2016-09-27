今天装回了 `ubuntu 16.04.1`, 唉，  
比 `麒麟 16` 和 `ubuntu 14.04` 强好多啊。  

- 原生 微信  
https://github.com/geeeeeeeeek/electronic-wechat/releases  

- Wine QQ 国际版 2012  
http://jingyan.baidu.com/article/e6c8503c6f5fa5e54f1a18de.html  

如果 `QQ` 不能输入中文, 用 sudo 打开  
> /usr/share/deepinwine/qqintl/wine-qqintl  

或  

> /usr/bin/wine-qqintl  

在 第二行 `export LANG=zh_CN.utf8` 下面加上:
``` properties
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
```
保存, 然后重启 `QQ` 即可.
