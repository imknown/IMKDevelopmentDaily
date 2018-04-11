很简单..  
只要把 `Windows` 中的 `%WINDIR%\Fonts` 中的 `simsun.ttc` 或者 `simsun.ttf`,  
复制到 `Wine` 中的 `Fonts` 中 即可.

`Wine` `Fonts` 路径, 例如: 
- ~/.wine/drive_c/windows/Fonts/
- ~/.longene/qq/dosdevices/c:/windows/Fonts/

如果是 `英文系统` 使用 `中文软件`, 可以在头部添加:
``` shell
export LC_ALL=zh_CN.UTF-8
```
