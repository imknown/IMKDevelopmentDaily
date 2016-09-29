接了别人的代码..  
居然是 Eclipse 项目.  
好吧...  

http://www.eclipse.org/downloads/packages/eclipse-android-developers-includes-incubating-components/neonr  
这个 Eclipse 出的 Android 开发工具 好恶心...  

插件:  
- https://github.com/fabioz/startexplorer
- https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/08/31_Eclipse%20SVN%20插件%20使用文档.md

### 2016-09-26 补充:  
- Ubuntu 下 Eclipse logcat 显示有误的问题:  
http://stackoverflow.com/questions/25010393/eclipse-logcat-shows-only-the-first-letter-from-each-message

↑ 打开 这个文件:  
> .../workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.andmore.ddms.prefs

里面写上 以下 `参考值`:  
``` properties
ddms.logcat.auotmonitor.level=error
ddms.logcat.automonitor.userprompt=true
devicePanel.Col0=246
devicePanel.Col1=53
devicePanel.Col4=84
eclipse.preferences.version=1
logcat.view.colsize.Application=156
logcat.view.colsize.Level=39
logcat.view.colsize.PID=58
logcat.view.colsize.TID=58
logcat.view.colsize.Tag=123
logcat.view.colsize.Text=677
logcat.view.colsize.Time=150
logcat.view.filters.list=name\: '', tag\: '', text\: '', pid\: '', app\: '', level\: 'verbose', name\: '', tag\: '', text\: '', pid\: '', app\: '', level\: 'verbose', 
logcat.view.font=1|Ubuntu|10.0|0|GTK|1|;
org.eclipse.andmore.ddms.explorer.data=81
org.eclipse.andmore.ddms.explorer.info=147
org.eclipse.andmore.ddms.explorer.name=111
org.eclipse.andmore.ddms.explorer.permissions=83
org.eclipse.andmore.ddms.explorer.size=57
org.eclipse.andmore.ddms.explorer.time=46
threadPanel.Col0=35
threadPanel.Col1=49
threadPanel.Col2=75
threadPanel.Col3=46
threadPanel.Col4=46
threadPanel.Col5=306
threadPanel.stack.col0=566
```
