**注: 部分方法并非我原创! 而是来自 Deepin 社区等!**

---

## 安装官方版 (QT4)
### 方法一: 覆盖升级

先下载 Deepin 仓库里面的 搜狗 2.2 版 (QT4), 他大概会自动帮你安装 `QT4` 相关的依赖:
> https://uos-packages.deepin.com/uos/pool/non-free/s/sogoupinyin/  
> https://packages.deepin.com/deepin/pool/non-free/s/sogoupinyin/  
> https://community-packages.deepin.com/deepin/pool/non-free/s/sogoupinyin/  

然后升级到 官方 2.3 版 (QT4)
``` sh
# 方法一: 自动覆盖升级
sudo apt upgrade

# 方法二: 手动覆盖升级
# sudo dpkg -i ./sogoupinyin_2.3.1.0112_amd64.deb
sudo apt install ./sogoupinyin_2.3.1.0112_amd64.deb
```

**之后, 请尽快 登出并重新登入, 或者重启系统.**


### 方法二: 直接用 2.3 安装
``` sh
# sudo dpkg -i ./sogoupinyin_2.3.1.0112_amd64.deb
sudo apt install ./sogoupinyin_2.3.1.0112_amd64.deb

# 如果抽风, 尝试安装 下面的模块
sudo apt install libqt4-declarative
```

**之后, 请尽快 登出并重新登入, 或者重启系统.**


## 配置 Fcitx
打开 `Fcitx 输入法 配置 (fcitx-configtool)`,  
在第一页 `输入法` 选项卡 中,  
确保 第一项是 `键盘(英语)`, 第二项才是 `搜狗拼音`.  
如果顺序不对, 会导致 搜狗拼音 切换 中英文之后, 会出现乱码.  
如果不添加 第一项英文键盘, 会导致 无法用快捷键 切换到英文.  

然后在 第二页 `全局设置` 选项卡 中,  
可以将 第二项 `切换输入法的额外键子` 改为 `SHIFT Both`.  

**之后, 请尽快 登出并重新登入, 或者重启系统.**

## 参考

这是我电脑里面 `fcitx` 相关组件, 可以参考一下.

``` sh
dlpc0052@dlpc0052-PC:~$ dpkg -l | grep fcitx
ii  fcitx                                             1:4.2.9.16-1+eagle                          all          Flexible Input Method Framework
ii  fcitx-bin                                         1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - essential binaries
ii  fcitx-config-common                               0.4.10.3-1+deepin                           all          graphic Fcitx configuration tool - common files
ii  fcitx-config-gtk                                  0.4.10.3-1+deepin                           amd64        graphic Fcitx configuration tool - Gtk+ 3 version
ii  fcitx-data                                        1:4.2.9.16-1+eagle                          all          Flexible Input Method Framework - essential data files
ii  fcitx-frontend-all                                1:4.2.9.16-1+eagle                          all          Flexible Input Method Framework - frontends metapackage
ii  fcitx-frontend-gtk2                               1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - GTK+ 2 IM Module frontend
ii  fcitx-frontend-gtk3                               1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - GTK+ 3 IM Module frontend
ii  fcitx-frontend-qt4                                1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - Qt4 IM Module frontend
ii  fcitx-frontend-qt5:amd64                          1.2.3.1-1+rebuild                           amd64        Free Chinese Input Toy of X - Qt5 IM Module frontend
ii  fcitx-libs                                        1:4.2.9.16-1+eagle                          all          Flexible Input Method Framework - metapackage for libraries
ii  fcitx-module-dbus                                 1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - D-Bus module and IPC frontend
ii  fcitx-module-kimpanel                             1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - KIMPanel protocol module
ii  fcitx-module-lua                                  1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - Lua module
ii  fcitx-module-x11                                  1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - X11 module and XIM frontend
ii  fcitx-modules                                     1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - core modules
ii  fcitx-ui-classic                                  1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - Classic user interface
ii  fcitx5-module-quickphrase-editor:amd64            1.2.3.1-1+rebuild                           amd64        Flexible Input Method Framework - Quick Phrase editor module
ii  libfcitx-config4:amd64                            1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - configuration support library
ii  libfcitx-core0:amd64                              1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - library of core functions
ii  libfcitx-gclient1:amd64                           1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - D-Bus client library for Glib
ii  libfcitx-qt0:amd64                                1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - Meta package for Qt library
ii  libfcitx-qt5-1:amd64                              1.2.3.1-1+rebuild                           amd64        Free Chinese Input Toy of X - D-Bus client libraries for Qt5
ii  libfcitx-qt5-data                                 1.2.3.1-1+rebuild                           all          Free Chinese Input Toy of X - data files for Qt5 integration
ii  libfcitx-utils0:amd64                             1:4.2.9.16-1+eagle                          amd64        Flexible Input Method Framework - utility support library
```


## 关于 搜狗企业版 (QT5)
> https://pinyin.sogou.com/linux/business/

### 优麒麟社区 企业版 (QT5)
> https://github.com/laomocode/fcitx-sogouimebs/releases  
> https://gitee.com/laomocode/fcitx-sogouimebs/releases  
> http://archive.ubuntukylin.com/ukui/pool/main/s/sogouimebs/  

可以正常使用, 但有很多 bug: Ctrl+V 莫名进入 V模式; 小键盘无法选词; 鼠标选词 进入 深度窗口切换模式 等.


### UOS 企业版 (QT5)
> https://uos-packages.deepin.com/uos/pool/non-free/s/sogouimebs/  
> https://community-packages.deepin.com/deepin/pool/non-free/s/sogouimebs/  

无法输入中文.
