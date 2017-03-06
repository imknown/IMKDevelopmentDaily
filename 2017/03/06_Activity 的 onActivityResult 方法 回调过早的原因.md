# 根本原因
启用了 **新的** `Task Stack`

#引发原因, 很多, 都是表象
- `Activity` 用了 `singleTask` 或者 `singleInstance`
- `Intent` **隐式** 启用了 `intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);`
- 非 `Root Activity` 用了 `android:clearTaskOnLaunch`
- ... 很多类似的
