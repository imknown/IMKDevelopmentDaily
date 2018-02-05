科普一下, `Material Design` 把 `Status Bar`, `Navigation Bar` 和 `(窗口模式下的) Window Bar` 统称为 `System Bar`...

# 原生
- `Android J` **不**支持 `状态栏/导航栏` `API`
- `Android K` 支持 `半透明` `渐变` 的 `状态栏/导航栏`, `内容在状态栏/导航栏下`
- `Android L` 支持 `状态栏/导航栏` `API`, 可以 `变色`, `完全透明`, `半透明`
- `Android M` 支持 `深色 状态栏 icon`
- `Android O` 支持 `深色 导航栏 icon`

# 小米
- `任何版本的 Android` + `MiUI 4~8` 支持 `Android` 原生的 `4.3`, `5.0`, `6.0` 特性 (`反射` 私有 `API`)
- `Android 6` + `MiUI 9` 必须使用 `Android 6` 原生 `api`, `反射方式` 返回值 为 `true`, 但是 **实际上是失败的**
- 目前 没有 `Android 6` +`MiUI 9 之前` 的 手机, 公司的 `红米 1s 联发科版` 可以刷 `开发版`, 有时间试试...

# 华为
- `Android 5.1` 的 `EMui 3.1 lite` 版本, 有的 `api` 被阉割了, 有的**升完级则正常** (版本号 **居然不变**, 真服了).  
  但是 `Android 5.1` 调用 `Android 4.4` 的 `半透明渐变` 的 `api` 是可以的

# Oppo
`Android 4.4` 的 `ColorOS 2` 的原生 `api` 被阉割了

# 锤子, 乐视 等
**小猫她居然能自适应...**
