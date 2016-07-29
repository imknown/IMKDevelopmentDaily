- Windows 10 和 ubuntu16.04 双系统 时间不对  
``` bash
sudo apt-get install ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc
```

参考自：  
http://www.cnblogs.com/qf19910623/p/5559514.html  

- 简单需要做的事情
  - http://www.cnbeta.com/articles/494747.htm
  - http://blog.csdn.net/skykingf/article/details/45267517
  - http://blog.csdn.net/keith_bb/article/details/51530585
