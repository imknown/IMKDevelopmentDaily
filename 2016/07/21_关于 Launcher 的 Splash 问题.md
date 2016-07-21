大致有两个思路:  
 1. 使用 `AndroidManifest.xml` 进行 配置
 2. 使用 `StartActivityController` 进行逻辑判断
 
具体思路如下:  
#### 思路 1
很简单, 直接上代码:  
``` xml
<!-- 第一屏 -->
<activity android:name=".SplashActivity">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />

        <category android:name="android.intent.category.LAUNCHER" />
        <category android:name="android.intent.category.MULTIWINDOW_LAUNCHER" />
    </intent-filter>
</activity>

<!-- 第二屏, 从 第一屏 自动进入, 随后 第一屏 this.finish() -->
<activity
    android:name=".HomePageActivity"
    android:launchMode="singleTask">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />

        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.HOME" />
        <category android:name="android.intent.category.MONKEY" />
    </intent-filter>
</activity>

<!-- 第三屏 详细页, 从 第二屏 点击 跳进来 -->
<activity android:name=".DetailActivity" />
```

#### 思路 2
参考 360桌面 7.1.6, 进行竞品分析 即可得知.  
:)
