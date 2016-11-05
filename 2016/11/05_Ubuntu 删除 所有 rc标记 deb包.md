``` bash
dpkg -l | grep ^rc | cut -d' ' -f3 | sudo xargs dpkg --purge
```
或者
``` bash
dpkg -l | awk '/^rc/ {print $2}' | xargs sudo dpkg --purge
```
或者
``` bash
dpkg -l | grep '^rc' | awk '{print $2}' | xargs dpkg --purge
```

参考:  
http://askubuntu.com/questions/181948/can-i-automatically-purge-every-package-ive-ever-uninstalled
