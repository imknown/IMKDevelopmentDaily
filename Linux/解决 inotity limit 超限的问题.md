``` bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

参考:
1. https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
1. https://blog.jetbrains.com/idea/2010/04/native-file-system-watcher-for-linux/
------
1. https://github.com/ember-cli/ember-cli/issues/3638#issuecomment-85825813  
1. https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers  
1. https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached  
1. https://askubuntu.com/questions/770374/user-limit-of-inotify-watches-reached-on-ubuntu-16-04
