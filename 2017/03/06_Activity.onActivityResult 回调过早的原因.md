根本原因: 启用了 新的 `Task Stack`, 引发的表象原因很多:  
`Activity` 用了 `singleTask` 啊,  
`Intent` **隐式** 启用了 `intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);`  
非 `Root Activity` 用了 `android:clearTaskOnLaunch`...
