# Windows 10 和 Ubuntu 16.04 双系统 时间不对  
## 方法一, 禁用 UTC, 使 Ubuntu 使用 本地时间
``` bash
# Fix
timedatectl set-local-rtc 1 --adjust-system-clock
```

``` bash
# Check
timedatectl
```

## 方法二, 使 Windows 使用 UTC (不推荐, 因为要禁用 `时间更新`)
``` cmd
timedatectl set-local-rtc 0
```

``` cmd
:: x86 (DWORD )
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1

:: x64 (QWORD)
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_QWORD /d 1
```

```
禁用 系统时间更新
```

参考自:  
http://ubuntuhandbook.org/index.php/2016/05/time-differences-ubuntu-1604-windows-10/


# p7zip 解压缩工具
``` bash
sudo apt-get install unrar p7zip-full cabextract
```
参考自：  
http://zhidao.baidu.com/question/74041450.html?loc_ans=253942660  


# 简单需要做的事情
  - http://www.cnbeta.com/articles/494747.htm
  - http://blog.csdn.net/skykingf/article/details/45267517
  - http://blog.csdn.net/keith_bb/article/details/51530585
  - http://staynoob.cn/post/linux/安装ubuntu16-04后要做的9件事/
