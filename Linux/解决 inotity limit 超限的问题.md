``` bash
echo fs.inotify.max_user_watches=16384 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

转载自:  
https://github.com/ember-cli/ember-cli/issues/3638#issuecomment-85825813  
https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers  
https://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached  
https://askubuntu.com/questions/770374/user-limit-of-inotify-watches-reached-on-ubuntu-16-04