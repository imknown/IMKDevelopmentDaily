`Adwaita` 是个 比较好看的主题, 不过 装完 `wine` 的 `QQ` 和 `微信`, 窗口最小化到 `Xfce-Panel` 之后 不会提示.  
但是 其他主题 并没有这个问题. 经过对比, 需要改动如下:

``` shell
sudo mousepad '/usr/share/themes/Adwaita/gtk-2.0/main.rc'
```

修改 `style "button"` 成 如下内容 (建议先备份):
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

备份一下原始数据:
``` cfg
style "button" {

  xthickness = 2
  ythickness = 2

  # For the sake of sanity style buttons this way
  engine "pixmap" {

    ###########
    # Buttons #
    ###########

    image {
      function = BOX
      state    = NORMAL
      file     = "assets/button.png"
      border   = {4, 4, 4, 4}
      stretch  = TRUE
    }

    image {
      function = BOX
      state    = PRELIGHT
      shadow   = OUT
      file     = "assets/button-hover.png"
      border   = {4, 4, 4, 4}
      stretch  = TRUE
    }

    # Don't add hover effect on pressed buttons
    image {
      function = BOX
      state    = PRELIGHT
      shadow   = IN
      file     = "assets/button-active.png"
      border   = {4, 4, 4, 4}
      stretch  = TRUE
    }

    image {
      function = BOX
      state    = ACTIVE
      file     = "assets/button-active.png"
      border   = {4, 4, 4, 4}
      stretch  = TRUE
    }

    image {
      function = BOX
      state    = INSENSITIVE
      file     = "assets/button-insensitive.png"
      border   = {4, 4, 4, 4}
      stretch  = TRUE
    }
  }
}
```
