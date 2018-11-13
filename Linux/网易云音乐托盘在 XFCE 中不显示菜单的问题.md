修改 `/usr/share/applications/netease-cloud-music.desktop`

把:
``` desktop
Exec=netease-cloud-music %U
```

改为:
``` desktop
Exec=env XDG_CURRENT_DESKTOP=Unity netease-cloud-music %U
```

参考: http://forum.ubuntu.com.cn/viewtopic.php?t=484624#p3199400
