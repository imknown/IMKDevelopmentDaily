# Windows 10 和 Ubuntu 16.04 双系统 时间不对  
``` bash
sudo apt-get install ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc
```
参考自：  
http://www.cnblogs.com/qf19910623/p/5559514.html  

### 2016-08-01 补充
上述方法, 实测无效.  
但是找到了 [`这个51cto 博客`][51cto xueyue8] 最下面的 [`v2ex 答案`][v2ex initialdp].  
使用如下命令, 实测 Ubuntu 16 可行:  
``` bash
sudo hwclock -w --localtime
#或者
sudo timedatectl set-local-rtc 1
```


[51cto xueyue8]: http://xueyue8.blog.51cto.com/4650249/1792933,  
[v2ex initialdp]: http://www.v2ex.com/t/274007#r_3110716


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
