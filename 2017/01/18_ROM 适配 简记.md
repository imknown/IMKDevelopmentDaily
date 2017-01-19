- 移植  
直接 `移植` 别的 `相似硬件机型` 的 `ROM`...

- PatchRom  
`MiUI` 和 `FlyMe` 等一般都是 基于 自己的 `PatchRom` 技术,  
配合 `base_cm` 来 `插桩` `反编译` 的 `smali`.

- cm-like  
`LineageOS` 或者 `CyanogenMod` 等 `cm-like` 的话,  
需要 引入 `官方`/`非官方` 的 `DeviceTree` 和 `VenderTree`, 直接 `make` 就行.

- AOSP/AOPK  
`谷歌官方` 的方式即可.


### 参考
- http://source.android.com/source/initializing.html
- https://github.com/SudaMod/android
- http://wiki.mokeedev.com/Setting_Up_A_Compile_Environment
- http://bbs.zhiyoo.com/thread-12529397-1-1.html
- http://www.oneplusbbs.com/thread-572886-1-1.html
