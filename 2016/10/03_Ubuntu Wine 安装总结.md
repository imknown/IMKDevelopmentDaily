# DeepinWine
https://github.com/wszqkzqk/deepin-wine-ubuntu

# WineHQ 官方
https://wiki.winehq.org/Ubuntu

参考: http://wiki.ubuntu.com.cn/Wine

# wine 配置工具
``` bash 
winecfg
```

# Winetricks
``` bash
sudo apt install winetricks
```

参考: https://wiki.winehq.org/Winetricks

# 32位 Wine 环境 (前缀)
创建
``` bash
env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winecfg
```

运行, 例如:
``` bash
env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 wine "xxx"
env WINEARCH=win32 WINEPREFIX=$HOME/.wine32 winetricks "xxx"

# 或者
env WINEPREFIX=$HOME/.wine32 wine "xxx"
env WINEPREFIX=$HOME/.wine32 winetricks "xxx"
```

参考: 
- https://github.com/imknown/IMKDevelopmentDaily/blob/master/2017/06/09_修复%20Wine%20文字显示为%20☐%20乱码的问题.md
- https://askubuntu.com/questions/231587/installing-dotnet-2-0-on-64-bit-machine
