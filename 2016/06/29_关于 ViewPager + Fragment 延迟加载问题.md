# 简述
因为 外层容器 ViewPager 具有自己的 缓存管理机制,  
所以 会打乱 Fragment 的 固有 延迟加载机制.  

大的方向, 目前总结的方法 有两种:  
 1. 破坏/重写 `ViewPager` 现有的 缓存机制;  
 2. 不修改 `ViewPager`, 增大 默认 加载缓存 的页数.  

# 大致思路
关于 `延迟加载`, 其实是 针对 第二个 方案,  
因为 第一个 本身 可能会 与 `Fragment` 有一些冲突.  
之前简单 研究了一下, 感觉 效果不好, 反而 逻辑变复杂.  
本末倒置, 遂寻弃之 改用 `原生` 方案.  

所以 至于 第二者, 也可以由 两种理解,  
这两种 方案 目前 都已经 实践过:  
 1. `Fragment` 自身的 懒加载, 用户 真正看到的时候, 才会 执行他的 `生命周期`;  
 2. `Fragment` 本身 已经 `Activity.attach()` 到 `父容器`, 但是 真正的 网络请求 什么的 是 懒加载的.  

# 关于 方法二
第二种 方案 我之前 没有查到,  
是 同事 给的一个思路, 有点意思, 也是 可行的.  
实际情景 也很简单, 类似 `iOS` 的 `底部导航栏/选项卡`,  
即 类似 [`Android Support Library 23.2`][1] 中的 `BottomNavigationBar`,  
控制 它上面的 `FrameLayout` 里面的 若干个 `Fragment` 进行切换.  
本质上是 判断 `Fragment` 是否为 `null`,  
从而 通过 切换 `底部导航栏/选项卡` 达到 控制 `懒加载`  
说了这么多, 其 `Fragment` 核心 `懒加载` 代码是:  

``` java
@Override
public void onStart() {
    super.onStart();

    // 可以在 在这里 发送网络请求 获取数据 等 耗时操作
}
```
[1]: https://developer.android.com/topic/libraries/support-library/revisions.html#rev23-2-0

`第一次` 切换到 指定的 `选项卡`,  
对应的 `Fragment` 为 `null`,  
会通过 `Transaction` 添加到 `Activity`,  
此时, 他的 `本身的生命周期` 也会 开始执行.  
然后 `第一次` 执行 `onStart()`.  
下一次 再切换到 这个 `Fragment` 的时候,  
判断发现 并不是 `null`, 于是 不会 在执行 `onStart()`,  

# 关于方法一
这是 网上 用的最多的方法, 主要是 配合 `ViewPager` 使用.  
之前说过了, 要突破 `ViewPager` 自身的限制, 即 使用:  

``` java
viewPager.setOffscreenPageLimit(4);
```

底层原理, 可以参考:  
https://android.googlesource.com/platform/frameworks/support/+/master/v4/java/android/support/v4/view/ViewPager.java#732  
https://android.googlesource.com/platform/frameworks/support/+/master/v4/java/android/support/v4/view/ViewPager.java#1012  

同 方法一, 你也需要 自己 通过 `Transaction` 控制 `Fragment` 非空与否,  

好了, 关键的 `BaseLazyLoadFragment.java`核心的 代码 整理如下:  

``` java
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * @author imknown 2016/5/3
 */
public abstract class BaseLazyLoadFragment extends NKBaseFragment {
    private final static String TAG = BaseLazyLoadFragment.class.getName();

    /**
     * Fragment视图 是否 渲染完毕 ({@link #onViewCreated(View view, Bundle savedInstanceState)})
     */
    private boolean mIsViewCreated;

    /**
     * 是否 已经 触发过 懒加载 ({@link #tryToLazyLoad()})
     */
    private boolean mHasLazyLoadedOnce;

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        Log.i(TAG, TAG + "onViewCreated");

        super.onViewCreated(view, savedInstanceState);

        mIsViewCreated = true;

        tryToLazyLoad();
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);

        // if (isVisibleToUser) {
        tryToLazyLoad();
        // }
    }

    /**
     * 尝试去 进行 懒加载 <br>
     * 条件: Fragment被用户可见 && 没有加载过数据 && Fragment视图已经渲染完毕
     */
    private void tryToLazyLoad() {
        if (getUserVisibleHint() && !mHasLazyLoadedOnce && mIsViewCreated) {
            mHasLazyLoadedOnce = true;

            lazyLoaded();
        }
    }

    /**
     * 触发懒加载，仅在满足fragment可见和视图已经准备好的时候调用一次
     */
    protected abstract void lazyLoaded();

    /**
     * View 被销毁后，将 重新触发 懒加载. <br>
     * 因为在 Viewpager 下, Fragment 不会再次新建. <br>
     * 而是 重新开始 生命周期 (从 {@link #onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)} 开始)
     */
    @Override
    public void onDestroyView() {
        super.onDestroyView();

        mHasLazyLoadedOnce = false;
        mIsViewCreated = false;
    }
}
```

然后 需要一个 `XxxFragment` 去 继承 这个类, 然后 实现 抽象方法:  

``` java
@Override
protected void lazyLoaded() {
    // 可以在 在这里 发送网络请求 获取数据 等 耗时操作
}
```

原理 我就不说了, `注释` 很完整了, 都是我 整理批注 的.  
