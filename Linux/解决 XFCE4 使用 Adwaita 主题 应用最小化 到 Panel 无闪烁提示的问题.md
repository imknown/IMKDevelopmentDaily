`Adwaita` 是个 比较好看的主题, 不过 装完 `wine` 的 `QQ` 和 `微信`, 窗口最小化到 `Xfce-Panel` 之后 不会提示.  
但是 其他主题 并没有这个问题. 经过对比, 需要改动如下:

``` shell
sudo mousepad '/usr/share/themes/Adwaita/gtk-2.0/main.rc'
```

修改 `style "button"` 成 如下内容 (建议先备份):
``` cfg
style "button" {  
  xthickness = 3
  ythickness = 3

# bg[NORMAL]        = @bg_color
  bg[PRELIGHT]      = shade (1.4, @selected_bg_color)
  bg[ACTIVE]        = shade (0.8, @bg_color)
  bg[SELECTED]      = shade (1.2, @selected_bg_color)
# bg[INSENSITIVE]   = @insensitive_bg_color

  # copied from '/usr/share/themes/Greybird/gtk-2.0/gtkrc'
  engine "murrine"
  {
    contrast            = 0.9
    highlight_shade     = 1.0
    lightborder_shade   = 1.2
    gradient_shades     = { 1.05, 1.0, 0.97, 0.97}
    border_shades       = { 1.1, 0.9 }
    shadow_shades       = { 1.0, 1.0 }
    reliefstyle         = 0
    roundness	        = 2
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
