这篇文章 有时间 好好总结写写.  
对人对己 帮助应该都非常大.  
都是我个人 工作实战的理解.  

------

经过实践, res 下 应该 这么放置:  
```
res
 |- layout
     |- activity_a.xml
     |- activity_bb.xml
     |- activity_ccc.xml
 |- layout-hdpi
     |- activity_dddd.xml
 |- layout-xhdpi
     |- activity_dddd.xml
```

**要加载 `activity_dddd.xml`**:  
- 如果 设备是 `xxhdpi`, 那么 他会直接 去找 `layout-xxhdpi`,  
  发现 没有, 就近原则, 便会使用 `layout-xhdpi`;  
- 如果 设备是 `xhdpi`, 那么 他会直接 去找 `layout-xhdpi`;  
- 如果 设备是 `hdpi`, 那么 他会直接 去找 `layout-hdpi`;  
- 如果 设备是 `mhdpi`, 那么 他会直接 去找 `layout`,  
  发现 没有, 就近原则, 便会使用 `layout-hdpi`.  
  如果 `layout` 中有的 `activity_dddd.xml`, 便会用 `layout`;  

参考:  
- https://developer.android.com/guide/practices/screens_support.html
- https://developer.android.com/training/basics/supporting-devices/screens.html

# 2016-11-12 补充
- http://blog.csdn.net/a220315410/article/details/11896189
