
修改 `/usr/share/applications/netease-cloud-music.desktop`

- 无 Root (需要 Kill 之前残余的进程):
``` desktop
Exec=env XDG_CURRENT_DESKTOP=Unity sh -c "unset SESSION_MANAGER && netease-cloud-music %U"
```

或者
``` desktop
Exec=sh -c "unset SESSION_MANAGER && env XDG_CURRENT_DESKTOP=Unity netease-cloud-music %U"
```

> 参考:
> - https://www.zhihu.com/question/277330447/answer/478510195
> - http://forum.ubuntu.com.cn/viewtopic.php?t=484624#p3199400

- 有 Root (不推荐):
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
