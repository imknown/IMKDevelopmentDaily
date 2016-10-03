# PPA 源
- 官方 (ppa:wine/wine-builds, 最新开发版?)  
https://launchpad.net/~wine/+archive/ubuntu/wine-builds  
https://wiki.winehq.org/Ubuntu
``` bash
sudo dpkg --add-architecture i386
sudo add-apt-repository ppa:wine/wine-builds
sudo apt-get update
sudo apt-get install --install-recommends winehq-devel
```

- Ubuntu Wine Team (ppa:ubuntu-wine/ppa)  
https://launchpad.net/~ubuntu-wine/+archive/ubuntu/ppa
``` bash
sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo apt-get update
sudo apt-get install wine1.8 winetricks
```

- Rico Tzschichholz (ppa:ricotz/unstable)
https://launchpad.net/~ricotz/+archive/ubuntu/unstable
``` bash
sudo add-apt-repository ppa:ricotz/unstable
sudo apt-get update
```

# wine 配置工具
``` bash 
winecfg
```

### 参考
http://wiki.ubuntu.com.cn/Wine
