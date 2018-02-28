``` bash
sudo gedit ~/.bashrc # 当前用户
# 或者
sudo gedit /etc/profile # 所有用户
# 或者
sudo gedit /etc/environment # 系统
```

最下面加入
``` bash
ANDROID_HOME="/home/imknown/me/Dev/Android/SDK/android-sdk-linux"
PATH=${ANDROID_HOME}/platform-tools:$PATH
```

刷新生效 (建议在 `bash` 执行, `zsh` 等可能会抽风)
``` bash
source ~/.bashrc
# 或者
source /etc/profile
# 或者
source /etc/environment
```

查看是否成功 (区分大小写)：
```
echo $ANDROID_HOME
echo $PATH
adb --version
```

**如果 `终端` 关闭之后 失效了, 注销或者重启一下即可.**

# 偷懒方式
``` bash
sudo apt install android-tools-adb android-tools-fastboot
```
