# 语法说明
``` sh
# 启用
adb shell pm enable <包名>

# 停用
adb shell pm disable-user <包名>

# 卸载
adb shell pm uninstall --user 0 <包名>

# 重装
adb shell cmd package install-existing <包名>

# 启动 APP
adb shell monkey -p <包名> -c android.intent.category.LAUNCHER 1
```

# 举例
``` sh
adb shell

# AnalyticsCore
pm uninstall --user 0 com.miui.analytics
# MSA
pm uninstall --user 0 com.miui.systemAdSolution
# 国际版 MSA
pm uninstall --user 0 com.miui.msa.global
# MAB
pm uninstall --user 0 com.xiaomi.ab

# MIUI Daemon
pm uninstall --user 0 com.miui.daemon

# Game
pm uninstall --user 0 com.xiaomi.gamecenter
pm uninstall --user 0 com.xiaomi.gamecenter.sdk.service

# 流氓应用
pm uninstall --user 0 com.android.browser
pm uninstall --user 0 com.android.quicksearchbox
pm uninstall --user 0 com.sohu.inputmethod.sogou.xiaomi
```

# 参考
- https://zhuanlan.zhihu.com/p/85032892
- http://bbs.xiaomi.cn/t-34591028
