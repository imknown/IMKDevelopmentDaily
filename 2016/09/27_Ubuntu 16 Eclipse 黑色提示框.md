用 sudo 打开, 如:  
> /usr/share/themes/Radiance/gtk-3.0/gtk-main.css  
> 和  
> /usr/share/themes/Radiance/gtk-2.0/gtkrc  

把
``` css
@define-color tooltip_bg_color #000000;
@define-color tooltip_fg_color #ffffff;
```

改为
``` css
@define-color tooltip_bg_color #f2edbc;
@define-color tooltip_fg_color #000000;
```

同时修改 `settings.ini`, 如:  
``` ini
[Settings]
gtk-color-scheme = "base_color:#ffffff\nbg_color:#f2f1f0\ntooltip_bg_color:#f2edbc\nselected_bg_color:#f07746\ntext_color:#3C3C3C\nfg_color:#4c4c4c\ntooltip_fg_color:#000000\nselected_fg_color:#ffffff\nlink_color:#DD4814\nbg_color_dark:#3c3b37\nfg_color_dark:#dfdbd2"
gtk-auto-mnemonics = 1
gtk-alternative-sort-arrows = true
```

保存 并 重启电脑 即可.

### 参考
- http://stackoverflow.com/questions/10383467/eclipse-javadoc-background-color-is-black
- http://www.linuxdiyf.com/linux/24196.html
- http://luveelin.blog.163.com/blog/static/119492341201261645432803/
- http://www.isvee.com/archives/589
- http://blog.csdn.net/ljphhj/article/details/15487637
