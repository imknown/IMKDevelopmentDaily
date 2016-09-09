并发量 一大, 我简直就要跪了..  

`ImageLoader.ImageCache` 这个接口的实现 要用 子线程:
- putBitmap() => (ExecutorService + Runnable) / AsyncTask
- getBitmap() => ExecutorService + FutrueTask

用了 效果还是不好..  
渣渣设计 `NetworkImageView`...
