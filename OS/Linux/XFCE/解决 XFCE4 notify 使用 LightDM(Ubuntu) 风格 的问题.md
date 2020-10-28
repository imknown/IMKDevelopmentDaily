``` bash
# Check the status
systemctl --user status xfce4-notifyd.service

# Try starting the service
systemctl --user start xfce4-notifyd.service

# Check the status again
systemctl --user status xfce4-notifyd.service

# Test
notify-send test test
```

参考 https://forum.xfce.org/viewtopic.php?pid=46010#p46010
