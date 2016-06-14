`selector` 和 `shape` 这些东西 我 做安卓 第一天 就遇到了.  
后来 逐渐 会看 https://dev.android.com/,  
还是会遇到 很多奇怪的问题.  
尤其是 在引入了 更多的状态 的时候,  
比如说 `android:state_pressed` `android:state_enable` `android:state_focused` 同时存在.  
此时 一定要 注意, 要预留一个 `默认状态`.  
即 一定要有 把 所有状态都包括在内.  

文件路径 `res/drawable/selector_button_background_common`, 用来 改变 按钮背景:  
注意 里面的注释. 这种 `drawable` 的 `selector` 里面的 `<item>` 是可以 再内嵌 `<shape>` 等标签.  
``` xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- imknown: 把 shape 抽出去写, 写是可以的 -->
    <!-- <item android:state_enabled="false" android:drawable="@drawable/shape_common_button_background_disable"> -->
    <!-- 两者都写的话, 里面的 <shape> 好像就不起作用了. -->
    <item android:state_enabled="false">
        <shape>
            <solid android:color="@color/colorDisable" />
        </shape>
    </item>

    <!-- imknown: 这个把这个 理解成 "默认值" -->
    <!-- 如果不写 android:state_pressed="false", 会懵逼 -->
    <item android:state_enabled="true" android:state_pressed="false">
        <shape>
            <solid android:color="@color/colorPrimary" />
        </shape>
    </item>

    <item android:state_pressed="true">
        <shape>
            <solid android:color="@color/colorPrimaryDark" />
        </shape>
    </item>
</selector>
```

对于 用来改变 文字颜色的 `res/color/selector_text_color_common`, 原理也差不多.  
但是要注意, 不能写 `android:drawable` 而是 `android:color`.  
因为放在了 `color` 文件夹, 而不是上面的 `drawable` 文件夹.  
`android:color` 直接 引用 `res/values/colors.xml` 里面 定义的静态常量 即可.  
所以 `color` 文件夹的 `selector` 里面的 `<item>` 要简单很多.

``` xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:color="@color/colorPrimary" android:state_pressed="false"/>
    <item android:color="@color/colorPrimaryDark" android:state_pressed="true"/>
</selector>
```

#### 参考
- https://developer.android.com/guide/topics/resources/drawable-resource.html
- https://developer.android.com/guide/topics/resources/color-list-resource.html
- https://developer.android.com/reference/android/graphics/drawable/package-summary.html
- https://developer.android.com/guide/topics/resources/more-resources.html#Color
- https://developer.android.com/reference/android/content/res/ColorStateList.html
