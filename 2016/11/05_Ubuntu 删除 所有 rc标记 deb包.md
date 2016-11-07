``` bash
dpkg -l | grep ^rc | cut -d' ' -f3 | sudo xargs dpkg --purge
```
或者
``` bash
dpkg -l | awk '/^rc/ {print $2}' | xargs sudo dpkg --purge
```
或者
``` bash
dpkg -l | grep '^rc' | awk '{print $2}' | sudo xargs dpkg --purge
```

参考:  
http://askubuntu.com/questions/181948/can-i-automatically-purge-every-package-ive-ever-uninstalled

# GUI 清理工具
- 优客助手  
http://www.ubuntukylin.com/application/show.php?lang=cn&id=268

- BleachBit  
https://github.com/az0/bleachbit  
https://apps.ubuntu.com/cat/applications/precise/bleachbit/
