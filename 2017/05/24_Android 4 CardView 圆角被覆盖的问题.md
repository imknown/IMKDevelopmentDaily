Android 4 貌似 只能先把 `CardView` 里面的 控件**预先**处理成 圆角的.  
至于圆角怎么来, 可以用:
- `Canvas`
- `<shape />`
- `android.graphics.drawable.Drawable.*`
- `覆盖圆角层`
- 封装了上面几个途径的第三方库
- ...

# CardView 兼容性 处理:
- http://www.jianshu.com/p/07097b562acb
- http://gmariotti.blogspot.tw/2014/11/android-5-card-and-images-with-rounded.html
- https://gist.github.com/gabrielemariotti/f5a176f1b941200fac68
- https://medium.com/@etiennelawlor/layout-tips-for-pre-and-post-lollipop-bcb2e4cdd6b2

# 圆角处理
- http://blog.csdn.net/lmj623565791/article/details/24555655
- http://blog.csdn.net/lmj623565791/article/details/41967509
- https://developer.android.com/reference/android/graphics/drawable/Drawable.html
- http://www.techrepublic.com/article/pro-tip-round-corners-on-an-android-imageview-with-this-hack/
