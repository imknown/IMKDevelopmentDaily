
修改 `/usr/share/applications/netease-cloud-music.desktop`

----

把:
``` desktop
Exec=netease-cloud-music %U
```

- 无 Root (不稳定, 需要 Kill 之前的进程) 改为:
``` desktop
Exec=env XDG_CURRENT_DESKTOP=Unity netease-cloud-music %U
```

> 参考:
> - http://forum.ubuntu.com.cn/viewtopic.php?t=484624#p3199400

----

- 有 Root 改为:
> 因为 Ubuntu 18.04 移除了 `gksudo`, 所以要折腾一下

Run-netease-cloud-music.sh
``` sh
#!/bin/bash
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY netease-cloud-music %U
```

``` desktop
Exec=Run-netease-cloud-music.sh
```

> 参考:
> - https://askubuntu.com/a/1067364/626522
> - https://unix.stackexchange.com/a/203149/203637
> - https://askubuntu.com/a/641616/626522
