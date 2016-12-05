# Windows
``` bat
netstat -ano | findstr "5037"
```

查询出 某些 `PID_A`, `PID_B`:
``` bat
tasklist /FI "PID eq PID_A"
# 或者
tasklist | findstr PID_A
```

``` bat
tasklist /FI "PID eq PID_B"
# 或者
tasklist | findstr PID_B
```
