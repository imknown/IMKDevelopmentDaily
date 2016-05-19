昨天说的 IjkPlayer (Android MediaPlayer-like) 播放前的准备进度 和 视频流截图,  
需要在 native 层 完成, 也就是 FFMpeg 的代码, 被封装成 so库 了, 回调 太简单了..  

``` java
/*
 * Called from native code when an interesting event happens. This method
 * just uses the EventHandler system to post the event back to the main app
 * thread. We use a weak reference to the original IjkMediaPlayer object so
 * that the native code is safe from the object disappearing from underneath
 * it. (This is the cookie passed to native_setup().)
 */
@CalledByNative
private static void postEventFromNative(Object weakThiz, int what,
        int arg1, int arg2, Object obj) {
    if (weakThiz == null)
        return;

    @SuppressWarnings("rawtypes")
    IjkMediaPlayer mp = (IjkMediaPlayer) ((WeakReference) weakThiz).get();
    if (mp == null) {
        return;
    }

    if (what == MEDIA_INFO && arg1 == MEDIA_INFO_STARTED_AS_NEXT) {
        // this acquires the wakelock if needed, and sets the client side
        // state
        mp.start();
    }
    if (mp.mEventHandler != null) {
        Message m = mp.mEventHandler.obtainMessage(what, arg1, arg2, obj);
        mp.mEventHandler.sendMessage(m);
    }
}
```  
参看 https://github.com/Bilibili/ijkplayer/blob/master/android/ijkplayer/ijkplayer-java/src/main/java/tv/danmaku/ijk/media/player/IjkMediaPlayer.java#L959-L987  

##### 此外, 关于 Zxing, 可能用的上的 基本资源有:  
- 官方:  
https://github.com/zxing/zxing  
http://search.maven.org/#search%7Cga%7C1%7Ccom.google.zxing  

``` groovy
compile 'com.google.zxing:core:3.2.1'  
compile 'com.google.zxing:android-core:3.2.1'  
compile 'com.google.zxing:android-integration:3.2.1'  
```

- 第三方:  
https://github.com/dm77/barcodescanner  
https://github.com/journeyapps/zxing-android-embedded  

类库相关的资源, 都在 [core][1] 下面. 所以 [core][1] 是必须的.  
网上关于 解析二维码 的帖子 看了一些， 
大多是对 zxing 官方的 [client/android][2] 目录下的项目 进行修改的.  
换言之 就是说 把 [client/android][2] 一部分代码 拷贝到 自己的项目中 进行定制.  
网上的文章, 我跟 现在 Google ZXing 的 [client/android][2] 项目 简单对比了一下, 还是 比较老旧的.  
所以 首选 可以考虑一下 第三方的 封装的类库.  
毕竟扫描二维码 涉及了 ZXing, Surface, 还有 Camera 核心技术.  
相比之下, ZXing 生成 内嵌 logo 的二维码 就容易很多~  

[1]: https://github.com/zxing/zxing/tree/master/core
[2]: https://github.com/zxing/zxing/tree/master/android/src/com/google/zxing/client/android
