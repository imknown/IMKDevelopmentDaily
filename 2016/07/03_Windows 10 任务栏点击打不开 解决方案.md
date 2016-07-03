今天帮妹子 修电脑, 系统进不去, 也没有 `Win7` 系统,  
直接帮她 重装了 `Win10`, 然后 安装了并更新了 所有的驱动.  
然后 问题来了, `开始按钮` 和 `通知中心` 都打不开了...  
百度了, 结果 找到了方案:  

首先 `以管理员身份` 运行 `PowerShell`, 运行方法 有很多种,  
推荐用 `开始按钮` 右键的 `命令提示符(管理员)` 启动 `powershell`.  
然后 执行命令: 
``` powershell
Get-AppxPackage | % { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppxManifest.xml" -verbose }
```
经过 三四分钟 等待, 即可 修复问题~  

参考:  
http://jingyan.baidu.com/article/d71306352f665b13fcf47560.html
