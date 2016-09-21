``` cmd
@chcp 65001

@Echo 使用方法
@Echo "ps | grep com.qmzhhchsh.yp"
@Echo "USER      PID   PPID  VSIZE  RSS   WCHAN              PC  NAME"
@Echo "adb logcat -v process |grep <PID>"

@adb shell
```
