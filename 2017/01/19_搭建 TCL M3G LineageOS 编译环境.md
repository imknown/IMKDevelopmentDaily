# 分区
建议 分出来 `200GB` ~ `500GB` 空白空间.
推荐挂载:  
 - Ubuntu Root: 40GB ~ 100GB
 - Ubuntu Boot: 500MB
 - Ubuntu Home: 150GB ~ 500GB
 - EFI: 默认
 - Swap: 随意, 不弄也行, 建议 跟 `物理内存` 差不对就行
 
 
# 安装 linux  
我用的 `Ubuntu 16.10 x64`,  
**推荐** `Ubuntu 14.04 x64`~`Ubuntu 16.04 x64`.  
用 `16.10` 折腾 `OpenJDK 7` 比较恶心.  


# 安装 必要软件  
https://source.android.com/source/initializing.html#installing-required-packages-ubuntu-1404  
`JDK 7` 安装教程 网上很多


# `clone` `LineageOS` `cm-12.1` 的 `git` 代码  
准备 Repo:
```
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage-googleapis.lug.ustc.edu.cn/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
```

建立 目录
```
mkdir ~/LineageOS
```
然后 `cd` 到 `LineageOS`,
```
repo init -u git://github.com/LineageOS/android.git -b cm-12.1
```


# `clone` `TCL-M3G` 的 `DeviceTree` 和 `VenderTree`  
https://github.com/ontherunvaro/android_device_tcl_q39/issues/4


# 使用 `ccache` 复用 `二进制`  
```
export USE_CCACHE=1
~/LineageOS/prebuilts/misc/linux-x86/ccache/ccache -M 50G
```


# 下载 编译需要的 `依赖库`  
```
repo sync -c -f -j8 --force-sync --no-clone-bundle
```
具体语法 参看 `repo sync --help`


# 编译  
```
. build/envsetup.sh
breakfast cm_q39-userdebug
brunch cm_q39-userdebug
```
耐心等待 1~4 小时, 最终 包 生成在
> ~/LineageOS/out/target/product/


# 参看
- https://github.com/imknown/IMKDevelopmentDaily/blob/master/2017/01/18_ROM%20%E9%80%82%E9%85%8D%20%E7%AE%80%E8%AE%B0.md
- https://github.com/imknown/android_device_tcl_q39
- https://github.com/imknown/proprietary_vendor_tcl
- https://github.com/imknown/android_hardware_qcom_media
- https://github.com/imknown/CHANGES
