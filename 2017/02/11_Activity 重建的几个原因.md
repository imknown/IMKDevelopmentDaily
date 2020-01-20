1. `Activity` 自身问题
   1. 处于后台一段时间, 资源不足时, 被系统回收. 重新 `Resume` 会 重建 `Activity`
   1. 进程崩溃后, `Task Stack` 从 `栈顶` 重建 `Activity`
   1. 启用了 `开发者模式` 的 `不保留活动`
   1. 类似原理 的操作
1. Configuration 发生改变 (前提是 未配置 `android:configChanged`, 也不推荐 去配置)
   1. 旋转屏幕
   1. `Multi-Window` 或者 `FreeForm` 导致的 `大小改变`
   1. 修改了 `系统设置` (如 `dpi`, `语言`, `字号`等)
   1. 类似原理 的操作
