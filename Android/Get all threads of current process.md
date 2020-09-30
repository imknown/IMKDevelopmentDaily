> https://mp.weixin.qq.com/s/CnhlvoUFGdoT_m_6DzrGSg

``` kotlin
// Author: imknown
Thread.getAllStackTraces().keys
   .sortedWith(compareBy({ it.threadGroup?.name }, { it.name }))
   .forEach { Log.e("Hello", "${it.threadGroup?.name}: ${it.name}") }
```

Android 11 AVD output:
```
main: Binder:30901_1
main: Binder:30901_2
main: Binder:30901_3
main: RenderThread
main: main
main: queued-work-looper
system: FinalizerDaemon
system: FinalizerWatchdogDaemon
system: HeapTaskDaemon
system: Jit thread pool worker thread 0
system: Profile Saver
system: ReferenceQueueDaemon
system: Signal Catcher
```
