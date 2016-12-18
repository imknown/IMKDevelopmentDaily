之前外包的 `MVP` 的 `presenter` 各种泄露 `view`.  
现在 我把 整个项目 使用 `view` 的地方, 都改为 `弱引用` + `空指针判断`,  
感觉 `内存占用` 好多了~  
有待继续考察~

#参考
1. https://github.com/imknown/MVPPractice
2. https://medium.com/google-developer-experts/weakreference-in-android-dd1e66b9be9d#.xdgb1w9sq
3. https://medium.com/@trionkidnapper/android-mvp-an-end-to-if-view-null-42bb6262a5d1#.2ibr20dq2
4. http://blog.csdn.net/sdkfjksf/article/details/51192852
5. http://blog.csdn.net/xiong_it/article/details/52610729
6. http://blog.csdn.net/womengmengyan/article/details/52192780
