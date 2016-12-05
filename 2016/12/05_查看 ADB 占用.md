# Windows
``` bat
netstat -ano | findstr "5037"
```

查询出 某些 `PID_A`:
``` bat
tasklist /FI "PID eq PID_A"
# 或者
tasklist | findstr PID_A
```

# Linux (待验证)
- Approach 1
``` bash
lsof -i:5037
```

查询出 某些 `PID_A`:
``` bash
ps -ef|grep PID_A
```

- Approach 2:
``` bash
netstat -tlnp|grep 5037
```
