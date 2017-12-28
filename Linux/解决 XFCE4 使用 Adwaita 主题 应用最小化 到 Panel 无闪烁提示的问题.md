`Adwaita` 是个 比较好看的主题, 不过 装完 `wine` 的 `QQ` 和 `微信`, 窗口最小化到 `Xfce-Panel` 之后 不会提示.  
但是 其他主题 并没有这个问题. 经过对比, 需要改动如下:

``` shell
sudo mousepad '/usr/share/themes/Adwaita/gtk-2.0/gtkrc'
```

修改 `L2472` 的 `style "button"` 成 如下内容 (建议先备份):
``` cfg
style "button" {  
  bg[ACTIVE]        = "#c2d1e1"
  bg[NORMAL]        = "#eeeeec"
  bg[PRELIGHT]      = "#ffffff"
  bg[SELECTED]      = "#ffbd8d"

  engine "xfce" {
      smooth_edge = true
      grip_style = none
  }
}
```

然后用 `Settings/Appearance` 重新选择 `Adwaita` 即可.
