今天装回了 `ubuntu 16.04.1`, 唉，  
比 `麒麟 16` 和 `ubuntu 14.04` 强好多啊。  

# 安装 Wine
**建议先安装 Wine, 虽然 Ubuntu 自带**  
[Ubuntu Wine 安装总结](https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/10/03_Ubuntu%20Wine%20%E5%AE%89%E8%A3%85%E6%80%BB%E7%BB%93.md)

# 安装 WeChat
## 原生应用
~~Update 2017-11-27: 不再推荐, Web 的 API 貌似会逐渐关闭, 请使用 `Wine`~~  
- https://github.com/geeeeeeeeek/electronic-wechat/releases
- https://github.com/trazyn/weweChat

## Wine 方式:
先从 `TIM` 或者 `QQ` 的 目录中, 拷贝一份 `RICHED20.DLL`.  
然后通过 `winecfg` 把 `riched20.dll` 改为 `Native(原版)` 即可.  

不行的话, 尝试安装:
```
winetricks riched20 msctf vcrun2005
```

参考:  
- http://tieba.baidu.com/p/4867218926#post_content_109004052038
- http://r9it.com/20170219/ubuntu-install-qq2013.html
- https://www.cnblogs.com/makefile/p/6079451.html
- http://www.jianshu.com/p/6aa175a534c4


# 安装 QQ
- **不建议 安装 `9.0.1`, 卡出翔, 没朋友. 建议安装 `8.9.4`, 稳定...**
   - https://dldir1.qq.com/qqfile/qq/QQ8.0/16954/QQ8.0.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.1/17216/QQ8.1.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.2/17724/QQ8.2.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.3/18033/QQ8.3.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.4/18357/QQ8.4.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.5/18600/QQ8.5.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.6/18781/QQ8.6.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.7/19071/QQ8.7.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.8/19876/QQ8.8.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9/19990/QQ8.9.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9.1/20437/QQ8.9.1.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9.2/20760/QQ8.9.2.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9.3/21149/QQ8.9.3.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9.4/21584/QQ8.9.4.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9.5/22062/QQ8.9.5.exe
   - https://dldir1.qq.com/qqfile/qq/QQ8.9.6/22427/QQ8.9.6.exe

- Longene Wine QQ 7.8 (~~推荐~~, 可自动升级到最新版)  
http://www.longene.org/forum/viewtopic.php?f=6&t=30516  

- Wine QQ 国际版 2012 (不推荐)  
http://www.ubuntukylin.com/application/show.php?lang=cn&id=279  

- 2016-10-24: ubuntu 16.04 完美运行新版QQ方案  
https://www.so-cools.com/?p=739

- 2017-03-07: 清风 QQ 和 Deepin QQ
  - http://phpcj.org/wineqq/
  - http://www.findspace.name/easycoding/1748

- 2017-08-24 (感谢 @JarvanMo & @nelson1110):
  - https://www.ithome.com/html/win10/307236.htm
  - http://tieba.baidu.com/p/2848294621 的 14楼
  - https://infinitescript.com/2017/03/install-qq-in-linux-with-wine/
  - http://yanke.info/?id=43

- 2017-11-02
  - http://www.jianshu.com/p/5f9330dd62a5
  - https://www.lulinux.com/archives/1319
  - https://www.findhao.net/easycoding/1748
  - https://github.com/askme765cs/Wine-QQ/wiki
 
- 2017-11-16
  - https://www.ubuntukylin.com/ukylin/forum.php?mod=viewthread&tid=30490


# 卸载 Wine QQ  
http://www.cnblogs.com/exmyth/p/4066090.html  


# 疑难杂症
## 64位 Ubuntu 无法启动 QQ
尝试 安装 32位 库:
``` bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
```
参考: http://blog.csdn.net/cwll2009/article/details/24449893


## 不能输入 QQ号 的问题
方法来源 参考上面的 `2017-08-24`:

``` bash
winecfg
```

然后 在 `Libraries` 选项卡 加入 `msvcp60` 和 `riched20`, 改为 `Native(原版)` 即可.


## QQ 不能输入中文的问题
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


## QQ 设置 闪退的问题 (err: ole)
```
winetricks mdac28
```


## 替换字体
尝试放置 `windows` 的 `宋体` `Microsoft YaHei` 等 字体:
> .../.wine/drive_c/windows/Fonts/simsun.ttf

参考:
- http://forum.ubuntu.org.cn/viewtopic.php?p=2669658
- http://www.linuxdiyf.com/linux/18884.html


## 英文系统 使用 中文 Wine
设置 `LC_ALL=zh_CN.UTF-8` 即可, 例如:
> Exec=env WINEPREFIX="$HOME/.wine" LC_ALL=zh_CN.UTF-8 wine C:\\\\windows\\\\command\\\\start.exe /Unix $HOME/.wine/dosdevices/c:/users/Public/Desktop/WeChat.lnk

具体用法 参考: https://github.com/imknown/IMKDevelopmentDaily/blob/master/2017/06/09_修复%20Wine%20文字显示为%20☐%20乱码的问题.md


## winecfg 配置 参考
**建议使用 Wine 32位 前缀, Windows 版本 建议使用 Windows XP**

> ~/.wine32/user.reg

``` reg
"*mtxdm"="native,builtin"
"*odbc32"="native,builtin"
"*odbccp32"="native,builtin"
"*oledb32"="native,builtin"
"*msls31"="native,builtin"
"*riched20"="native,builtin"
"*riched32"="native,builtin"
```


