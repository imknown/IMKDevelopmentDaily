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
-WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg
```

运行, 例如:
``` bash
env WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks "xxx"

# 或者
env WINEPREFIX=~/.wine32 winetricks "xxx"
```

参考: https://askubuntu.com/questions/231587/installing-dotnet-2-0-on-64-bit-machine
