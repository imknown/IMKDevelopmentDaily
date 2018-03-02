# 启用
- Ubuntu 16.04 (Unity)
``` bash
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
```

- Ubuntu 17.04 (Gnome)
``` bash
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
```

# 关闭
- Ubuntu 16.04 (Unity)
``` bash
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window false
```

- Ubuntu 17.04 (Gnome)
``` bash
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'skip'
```


# 参考
- http://www.cnblogs.com/zawn/p/3839609.html (适用于 unbutu 16)
- https://github.com/micheleg/dash-to-dock/blob/master/schemas/org.gnome.shell.extensions.dash-to-dock.gschema.xml#L3
