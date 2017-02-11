1. 处于后台一段时间 或者 (部分系统)启动 `系统 APK` 后,  
   重新 `Resume` 可能会 重建 `Activity`.
2. 程序崩溃, `Task Stack` 从 `栈顶` 重建 `Activity`.
3. 启用了 `开发者模式` 的 `不保留活动`.
4. `Multi-Window` 或者 `FreeForm` 的 `大小改变`.
5. 修改系统设置 (如 `dpi`, `语言`, `字号`等).  
   可能是因为影响了 `Resources ` 的 `Configuration`.
6. `类似原理` 的操作..
