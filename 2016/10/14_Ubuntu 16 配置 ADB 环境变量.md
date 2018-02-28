# 手动方式
## 编辑环境变量

> 参考: http://blog.csdn.net/tsuilei/article/details/4714256

- ZSH
``` zsh
# 当前用户
gedit ~/.zprofile

# 所有用户
sudo gedit /etc/zsh/zproile
```

- bash
``` bash
# 当前用户
gedit ~/.bashrc

# 所有用户
sudo gedit /etc/profile

# 系统 (如果 ZSH 不使用 zprofile, 推荐请使用这个, 因为 zsh 不兼容 部分 bash 语法. 其他几个里面, 都有 bash 命令)
sudo gedit /etc/environment

# 系统
sudo gedit /etc/bash.bashrc
```

最下面加入
``` bash
ANDROID_HOME="/home/imknown/me/Dev/Android/SDK/android-sdk-linux"
PATH=${ANDROID_HOME}/platform-tools:$PATH
```

## 刷新生效
**建议在 `bash` 执行, `zsh` 等可能会抽风**

- ZSH  
如果 `ZSH` 使用了 `非 zproile 方式`,  
建议修改 `/etc/environment`, 并在 `~/.zshrc` 加入 `source /etc/environment` 以生效.  

> 参考: https://github.com/robbyrussell/oh-my-zsh/issues/3807

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
