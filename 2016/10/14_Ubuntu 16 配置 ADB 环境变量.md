# 手动方式
## 编辑环境变量
``` bash
# 当前用户 (bash)
gedit ~/.bashrc

# 所有用户 (bash)
sudo gedit /etc/profile

# 系统 (bash)
sudo gedit /etc/environment

# 系统 (bash)
sudo gedit /etc/bash.bashrc
```

``` zsh
# ZSH
sudo gedit /etc/zsh/zproile
```

最下面加入
``` bash
ANDROID_HOME="/home/imknown/me/Dev/Android/SDK/android-sdk-linux"
PATH=${ANDROID_HOME}/platform-tools:$PATH
```

## 刷新生效
**建议在 `bash` 执行, `zsh` 等可能会抽风**

``` bash
source ~/.bashrc
source /etc/profile
source /etc/environment
source /etc/bash.bashrc

# 使用 ZSH (非 /etc/zsh/zproile 方式), 可以在 ~/.zshrc 加入 上述的对应的命令 才会生效
```

## 查看是否成功 (区分大小写)：
```
echo $ANDROID_HOME
echo $PATH
adb --version
```

# 偷懒方式
``` bash
sudo apt install android-tools-adb android-tools-fastboot
```
