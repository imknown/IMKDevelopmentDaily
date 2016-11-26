# 1. 判断
一般用 `GPS Provider` 判断,  
也可以用 `ContentObserver` 查询 `Settings` 的值.

# 2. 监听
 1. Broadcast Receiver
 2. ContentObserver
 3. GpsStatus.Listener / LocationListener
 4. 利用 `onActivityResult` 等 + [上面的 第一步](https://github.com/imknown/IMKDevelopmentDaily/new/master/2016/11#1-判断) 进行递归判断

- http://stackoverflow.com/questions/12665558/gps-status-enabled-disabled-broadcast-receiver
- http://stackoverflow.com/questions/20673620/how-to-trigger-broadcast-receiver-when-gps-is-turn-on-off
- http://stackoverflow.com/questions/32860101/how-to-implement-gps-status-change-listener
