# 手动方式
## 编辑环境变量

> 参考: http://blog.csdn.net/tsuilei/article/details/4714256

- ZSH
``` zsh
# 当前用户
gedit ~/.zshrc
```

- bash
``` bash
# 当前用户
gedit ~/.bashrc

# 所有用户 (不推荐)
sudo gedit /etc/profile

# 系统 (不推荐)
sudo gedit /etc/environment

# 系统
sudo gedit /etc/bash.bashrc
```

最下面加入
``` bash
export ANDROID_SDK_ROOT="/your_android_sdk_location"
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
```

## 刷新生效

- ZSH  
貌似自动生效, 新开 ZSH 即可.

- bash
``` bash
source ~/.bashrc

source /etc/profile

source /etc/environment

source /etc/bash.bashrc
```

## 查看是否成功 (区分大小写)：
```
echo $ANDROID_HOME
echo $PATH
adb --version
```

## 参考
- http://blog.csdn.net/tsuilei/article/details/4714256
- https://github.com/robbyrussell/oh-my-zsh/issues/3807
# 偷懒方式
``` bash
sudo apt install android-tools-adb android-tools-fastboot
```
