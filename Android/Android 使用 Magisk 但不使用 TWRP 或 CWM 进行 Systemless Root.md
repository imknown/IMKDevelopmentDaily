# 0. 准备工作
## 注意
如果你的手机 是 `小米` 或 `三星` 之类的品牌,  
可能 需要 借助 `MiFlash` 或者` ODIN` 这些 高级图形工具.  
本文只讲 **没有魔改过的** 一般 `Android` 情况 (通过 `fastboot` 命令).  
工具请自行百度怎么使用. 道理基本是一样的.

## 科普一下 高通SoC 救砖
> 低砖: 卡在(bootloop) 第二屏 动画  
> 中砖: 卡在(bootloop) 第一屏 boot  
> 高砖: 屏幕不亮, 但手机能震动等 (非硬件问题)  

- `低砖` `中砖` 基本 `卡刷` 或者 `线刷` **正确的 `ROM`** 就能正常启动.
- 高砖 可能 `分区` 等 都挂掉了, 需要 用 `磁盘工具` 删掉所有分区,  
  并进入 `高通 900x 模式` + `Emergency Download Mode` + `QPST` 量产了.

# 1. 验证工作 (不会用命令号的, 自行百度)
## 下载 adb 工具
https://developer.android.google.cn/studio/releases/platform-tools.html?hl=zh

## 查看手机状态
``` bash
adb devices -l
```

不确定自己解没解锁的, 可以先试试如下命令,  
看看 是否可以进入 `BootLoader`
``` bash
adb reboot bootloader
```

## 结论
如果执行命令之后, `进不了 BootLoader` 或者 `自动重启`,  
恭喜你, **基本要解锁了**.   
请先解锁 `OEM 锁` 或者 `BootLoader (BL 锁)`, 再继续往下看.  
`解锁的命令行` 请自行百度. `ROM` 各不相同.  

# 2. 开始刷
## 获取 Stock `boot.img`
下载 你 **当前手机对应版本** 的 `Stock(官方) ROM` 的 `zip 刷机包`,  
**别下错版本了, 后果自负啊**!!  
然后在 `zip 刷机包` 中, 解压出 `boot.image`.  
并把 `boot.image` 扔到手机里.

## 生成 `patch-boot.img`
手机 安装最新版 `Magisk Manager`,  
然后 点击 `安装`, 再选择 `修补 Boot 镜像文件`.  
他会自己 **自动下载** `最新版 Magisk 二进制`,  
并在 **下载完毕之后自动执行** `patch boot` 等操作.

成功之后 会在 `/SDCard/MagiskManager` 生成 `patch-boot.img`.

然后把这个 `patch-boot.img` 导到 `电脑`.

## 刷刷刷
让手机 进入 `BootLoader`,  
**没有魔改过** 的 `Android` 可以通过 下面代码进入:
``` bash
adb reboot bootloader
```

进入 `BootLoader` 后, 执行如下命令查看手机状态:
``` bash
fastboot devices
```

然后执行:
``` bash
fastboot boot patch-boot.img
fastboot reboot
```

``` text
注: 
fastboot boot xxx 命令 是临时通过 xxx 启动系统, 
所以比较安全, 相当于后悔药. 
如果失败了的话, 重启一下 xxx 就没了.
```

## 验证效果
如果不能正常启动, 百度查查 看有没有 **该机型** `翻车解决方案` 吧...  

如果正常启动, 进入 `MagiskManager` 查看, 是否 刷入成功(显示 已安装).  
如果现实成功, 恭喜你, 这个 `patch-boot.img` 可以长期使用了.

## 永久刷入
执行如下命令 永久刷入, 不然 重启之后 会失效:
``` bash
adb reboot bootloader
fastboot flash boot patch-boot.img
fastboot reboot
```

好了, 尽情地 体验 `Root` 吧!

# 3. 关于 `OTA` 和 `卸载 Root`
进行 `OTA` 之前, 请 **务必** 在 `Magisk Mnanger` 卸载 `Root`.  
他会 **自动** 帮你执行 "还原成 最初的 `Stock` `boot.img`" 等操作.
相当于 卸载了 `Root`. 基本是无痛的.

`OTA` 成功之后, 还需要 **重新再来一边** 本文的流程.  
不过 时间长了也就熟练了. 也不是很难.

如此繁琐无聊的体力活, 是否有 "想找找 别人封装好的脚本" 的 冲动了已经?  
哈哈, 自己找吧 或者 自己写吧. 已超出本文范畴.

# 4. 相关链接
- Magisk 官网  
https://forum.xda-developers.com/apps/magisk/official-magisk-v7-universal-systemless-t3473445
