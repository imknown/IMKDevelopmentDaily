# 禁用 Turbo Boost(睿频)
``` bash
sudo gedit /sys/devices/system/cpu/intel_pstate/no_turbo
```
把值修改为 `1` 然后保存, **可能会报错, 请无视**

### 参考
- http://askubuntu.com/questions/764204/cant-disable-turbo-boost-since-ubuntu-16-04

------

# 查看 CPU 主频
``` bash
lscpu | grep MHz
# 或者
grep MHz /proc/cpuinfo
```

------

# 查看 CPU 温度
``` bash
sensors
```

### 参考
- http://askubuntu.com/a/759154/626522
- http://askubuntu.com/a/15833/626522


# 组合命令
``` bash
echo $'\n======================' \
&& echo "== 温度" \
&& echo $'======================' \
&& sensors \
\
&& echo ====================== \
&& echo "== CPU 主频" \
&& echo ====================== \
&& lscpu | grep MHz \
\
&& echo ====================== \
&& grep MHz /proc/cpuinfo
```
