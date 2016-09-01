`Android 5 之前` 可以通过 `ScrollView` + `android:windowSoftInputMode="adjustResize"`  
在 键盘 弹起来之后, 键盘上面的页面 是可以滑动的.  
但是 `Android 5 及其之后` 就不起作用了.  
查了一下, 果然有很多人发现了这个问题:  

- http://stackoverflow.com/questions/27167176/android-adjust-scrollview-when-keyboard-is-up-for-android-5-0-lollipop
- http://stackoverflow.com/questions/21092888/windowsoftinputmode-adjustresize-not-working-with-translucent-action-navbar
