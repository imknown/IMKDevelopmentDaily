# AndroidLowLevelDetector - SSOT 与 UDF

> 临时分析文件, 基于 2026-08-22 代码审查, 可随时删除.
> 范围:`app` / `base` / `build-logic` 三个模块的状态管理与单一事实源实践.
> 说明: UDF(单向数据流) 与 SSOT(单一事实源) 合并讨论, 不分节; 每条问题标注类型, 优先级,**源码证据**与**改法示意**, 修复建议已并入各条目, 整体按优先级从高到低排列.

## 目录

### P0

- [**1.** ✅ \[UDF\] 状态被外部可变引用穿透 -> StateFlow 静默失效(定时炸弹)](#1-udf-状态被外部可变引用穿透---stateflow-静默失效定时炸弹)
- [**2.** ✅ \[UDF\] Fragment 直接读写 adapter 内部数据容器](#2-udf-fragment-直接读写-adapter-内部数据容器)

### P1

- [**3.** ✅ \[UDF\] 下拉刷新由 View 编排取数与写状态](#3-udf-下拉刷新由-view-编排取数与写状态)
- [**5.** \[健壮性\] 检测链路无兜底异常处理, 单个检测点异常 = 应用崩溃](#5-健壮性-检测链路无兜底异常处理-单个检测点异常-应用崩溃)

### P2

- [**6.** ✅ \[UDF\] payload 按 `lastIndex` 硬编码定位目标行](#6-udf-payload-按-lastindex-硬编码定位目标行)
- [**7.** ✅ \[UDF\] 状态写入 API 未封装](#7-udf-状态写入-api-未封装)
- [**8.** ✅ \[UDF\]`State.toValue()` 不安全强转](#8-udfstatetovalue-不安全强转)
- [**9.** ✅ \[UDF\] 全量与局部刷新策略混用](#9-udf-全量与局部刷新策略混用)
- [**10.** \[UDF\] 设置读取跨越三层, 无统一网关](#10-udf-设置读取跨越三层-无统一网关)
- [**11.** \[UDF\] companion 级 SharedFlow 事件总线](#11-udf-companion-级-sharedflow-事件总线)
- [**12.** \[SSOT\] 设置双通道](#12-ssot-设置双通道)
- [**13.** \[SSOT\]`Build.ID` 双渲染(同类事实两条代码路径)](#13-ssot-buildid-双渲染同类事实两条代码路径)
- [**14.** \[SSOT\] 属性键常量分散三文件, 无单一"属性字典"](#14-ssot-属性键常量分散三文件-无单一属性字典)

### P3

- [**15.** \[UDF\]`MainViewModel.lastId` 非响应式](#15-udfmainviewmodellastid-非响应式)
- [**17.** \[SSOT\]`MainViewModel.lastId` 双份存储](#17-ssotmainviewmodellastid-双份存储)
- [**18.** \[SSOT\] 查询层混入表示层文案](#18-ssot-查询层混入表示层文案)
- [**19.** \[SSOT\] 模型层直接产出展示文案](#19-ssot-模型层直接产出展示文案)
- [**20.** \[SSOT\] 可变全局单例(健壮性)](#20-ssot-可变全局单例健壮性)
- [**21.** \[SSOT\] 反射调用隐藏 API(健壮性)](#21-ssot-反射调用隐藏-api健壮性)
- [**22.** \[健壮性\] 阻塞 IO 全部跑在 `Dispatchers.Default`](#22-健壮性-阻塞-io-全部跑在-dispatchersdefault)
- [**23.** \[SSOT\] 每次网络请求新建 `HttpClient(OkHttp)`](#23-ssot-每次网络请求新建-httpclientokhttp)

### ⏸ 暂缓

- [**4.** ⏸ \[SSOT\] 内核版本双实现(同一事实两条路径)](#4-ssot-内核版本双实现同一事实两条路径)
- [**16.** ⏸ \[UDF\] 依赖在 View 层手工组装, 无组合根](#16-udf-依赖在-view-层手工组装-无组合根)
- [**24.** ⏸ \[工程\] 检测逻辑零测试保护](#24-工程-检测逻辑零测试保护)

## 总体结论

| 原则 | 评价 | 关键缺口 |
| --- | --- | --- |
| **UDF** | 部分遵循 | View 主动取数回填; 状态被外部可变引用穿透(StateFlow 静默失效); 事件总线替代状态 |
| **SSOT** | 整体健康 | 内核版本双实现;`Build.ID` 双渲染; 设置"值 + 广播"双通道; 属性键常量分散 |
| **健壮性/工程** | 中风险 | 检测链路无兜底异常(单点崩溃); 阻塞 IO 挤占 Default 池; 网络 client 每次重建; 检测逻辑零测试 |

[//]: # (---)

## 一, 遵循的实践 ✅

- `[UDF]`[BaseListViewModel.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/base/list/BaseListViewModel.kt) 暴露**只读** `StateFlow<State<List<MyModel>>>`(私有 `MutableStateFlow` 兜底), UI 仅通过 `flowWithLifecycle(...).collect` 消费.
- [UDF] 显式状态模型 `sealed class State { NotInitialized / Done }`([StateExt.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/common/StateExt.kt)), 替代裸 nullable 字段.
- [UDF] 数据流方向正确: Repository -> ViewModel -> StateFlow -> View 单向.
- [SSOT] 设置写入路径唯一: 整个 `app/src/main/java` 无任何 `.edit()`/`putString` 散落调用, 全部由 Preference 系统写入同一个 default SharedPreferences;
- [SSOT] 设置读取集中:`MyApplication.sharedPreferences` 唯一访问器([MyApplication.kt](app/src/main/java/net/imknown/android/forefrontinfo/base/MyApplication.kt), L25-L27);
- [SSOT] Preference key 收敛在 `R.string.*_key`, Kotlin 侧仅 `getMyString()` 一个解析入口;
- [SSOT] 主题存储与应用分离:`setMyTheme` 只映射 `NightMode`, 不写存储([MyApplication.kt](app/src/main/java/net/imknown/android/forefrontinfo/base/MyApplication.kt), L48-L68);
- [SSOT] 依赖版本: version catalog(`gradle/libs.versions.toml`);
- [SSOT] 构建配置: flavors / signing 由 `build-logic` convention plugins 统一管理;
- [SSOT] lld.json 生命周期:`LldManager` 单点负责 asset 复制 / 文件读写 / 版本比对 / 解析([LldManager.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/common/LldManager.kt));
- [SSOT] 底层访问集中:`PropertyManager` / `ShellManager` 单例 + `getStringProperty` / `getBooleanProperty`([PropertyExt.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/common/PropertyExt.kt)),`getShellResult`([ShellExt.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/common/ShellExt.kt)) 统一 helper;
- [SSOT] Preference key 不随语言漂移: 所有 `*_key` 资源均声明 `translatable="false"`([strings.xml](app/src/main/java/net/imknown/android/forefrontinfo/ui/settings/res/values/strings.xml), L6), key 值与翻译隔离, 切语言不会丢设置.

---

## 二, 问题与修复建议(共 24 条, 按优先级从高到低)

> `[P0]`...`[P3]` 为优先级,`UDF` / `SSOT` / `健壮性` 为问题类型;`#N` 为稳定编号.
> 代码片段均为源码摘录,`<-` 标注问题点; 每条末尾附**改法示意**(修复建议已并入各条目, 不再单独成节).

### P0

#### 1. [UDF] 状态被外部可变引用穿透 -> StateFlow 静默失效(定时炸弹)

问题: UI 事件把 adapter 持有的**可变 list**传回 ViewModel, ViewModel 原地改写 `MyModel.detail`, 从不更新 `modelsStateFlow`, 状态真相落在共享可变对象上.

```kotlin
// HomeFragment.kt:41-48 -- View 把 adapter 内部容器直接传给 ViewModel
viewLifecycleOwner.lifecycleScope.launch {
    val flow = SettingsViewModel.outdatedOrderChangedSharedFlow
    flow.flowWithLifecycle(viewLifecycleOwner.lifecycle).collect {
        val models = myAdapter.myModels                          // <- 直接取 adapter 的数据容器
        listViewModel.payloadOutdatedTargetSdkVersionApk(models)
        myAdapter.notifyItemChanged(models.lastIndex, MyAdapter.PAYLOAD_DETAILS)
    }
}
```

```kotlin
// HomeViewModel.kt:172-183 -- 原地改写, 绕过 modelsStateFlow
@MainThread
suspend fun payloadOutdatedTargetSdkVersionApk(myModels: List<MyModel>) {
    if (myModels.isEmpty()) {
        return
    }
    val lld = fetchOfflineLldOrNull().lld
        ?: return
    myModels.last().detail = withContext(Dispatchers.Default) {  // <- var detail 原地改写
        homeRepository.getOutdatedTargetSdkVersionApkModel(lld).detail
    }
}
```

```kotlin
// BaseListViewModel.kt:27-30 -- 此处从未被调用, StateFlow 保持旧引用
@MainThread
fun setModels(tempModels: List<MyModel>) {
    modelsStateFlow.value = State.Done(tempModels)
}
```

> 更正(2026-08-22 复审): 当前实现下旋转**不会**丢数据 -- [BaseListFragment.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/base/list/BaseListFragment.kt), L59-L62 用 `clear()+addAll()` 让 adapter 与 StateFlow 持有同一批对象引用, 改写"碰巧"同步生效.
>
> 但"碰巧"掩盖了更深的问题:
> - `modelsStateFlow.value` 的对象引用未变 -> `State.Done` 的 data class equals 恒等 -> **StateFlow 不重新发射**, 任何其他 collector 永远看不到变化, UI 只能靠手动 `notifyItemChanged`;
> - 一旦未来任一环节引入不可变快照(`toList()` / DiffUtil / immutable collections), 旋转丢数据 bug 立即炸开 -- 这是**定时炸弹**而非已爆炸的 bug;
> - 根因:`MyModel.detail` 是 `var`([MyModel.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/base/list/MyModel.kt), L7-L10), 状态真相落在共享可变对象上, StateFlow 退化为引用持有者,**名义 SSOT 实际不是**.

**改法示意:**

```kotlin
// ① MyModel.detail 改不可变, 配合 copy 更新
class MyModel(
    val title: String,
    val detail: String,                       // var -> val
    @param:AttrRes val color: Int = RES_ID_NONE
)

// ② BaseListViewModel: 显式更新状态, StateFlow 正常发射
fun updateModelDetail(targetIndex: Int, newDetail: String) {
    modelsStateFlow.update { state ->
        if (state !is State.Done) {
            return@update state
        }
        val list = state.value
        if (targetIndex !in list.indices) {
            return@update state
        }
        State.Done(list.toMutableList().apply {
            this[targetIndex] = this[targetIndex].copy(detail = newDetail)
        })
    }
}

// ③ HomeViewModel: 事件进 VM, 不再接收 adapter list
suspend fun payloadOutdatedTargetSdkVersionApk() {
    val lld = fetchOfflineLldOrNull().lld
        ?: return
    val newDetail = withContext(Dispatchers.Default) {
        homeRepository.getOutdatedTargetSdkVersionApkModel(lld).detail
    }
    updateModelDetail(targetIndex = /* 见 #6 改法 */, newDetail)
}

// ④ HomeFragment: 只发事件, adapter 由 StateFlow 驱动刷新
flow.flowWithLifecycle(viewLifecycleOwner.lifecycle).collect {
    listViewModel.payloadOutdatedTargetSdkVersionApk()   // 删除 myAdapter.myModels 传参
}
```

#### 2. [UDF] Fragment 直接读写 adapter 内部数据容器

问题: View 层绕过 ViewModel 直接触碰渲染层数据, UDF 的"View 只读状态"被破坏.

```kotlin
// HomeFragment.kt:44 -- Fragment 直接读 adapter 的可变数据容器
val models = myAdapter.myModels
listViewModel.payloadOutdatedTargetSdkVersionApk(models)
```

**改法示意:** 与 #1 同源, 随 #1 一并修 -- Fragment 删除 `myAdapter.myModels` 传参(#1 改法 ④), adapter 内容完全由 `modelsStateFlow` 驱动, 不再被 View 读写.

### P1

#### 3. [UDF] 下拉刷新由 View 编排取数与写状态

问题: View 直接调用数据采集方法并回填状态, 取数/写状态的编排逻辑在 View, 不在 ViewModel.

```kotlin
// BaseListFragment.kt:103-108
binding.swipeRefreshLayout.setOnRefreshListener {
    viewLifecycleOwner.lifecycleScope.launch {
        val list = listViewModel.collectModels()   // <- View 直接取数
        listViewModel.setModels(list)              // <- View 回填状态
    }
}
```

**改法示意:** 收敛为一次性事件, 取数与写状态收进 ViewModel.

```kotlin
// BaseListViewModel
fun refresh() {
    viewModelScope.launch {
        val list = collectModels()
        setModels(list)
    }
}

// BaseListFragment: View 只发事件
binding.swipeRefreshLayout.setOnRefreshListener {
    listViewModel.refresh()
}
// isRefreshing 的停止仍由既有 collect 分支负责
```

#### 5. [健壮性] 检测链路无兜底异常处理, 单个检测点异常 = 应用崩溃

问题:`detect()` 连续调用约 20 个 `detectXxx()` 无任何 try/catch; 底层 `toInt()` / `Settings.getInt` / 反射等单点异常会一路冒泡到协程, 未捕获即崩溃.

```kotlin
// HomeViewModel.kt:133-160 -- 20 个 detect* 无 try/catch 包裹
withContext(Dispatchers.Default) {
    tempModels += homeRepository.detectAndroid(lld)
    tempModels += homeRepository.detectBuildId(lld)
    tempModels += homeRepository.detectKernel(lld)     // <- 内部读 os.version
    tempModels += homeRepository.detectSar()           // <- 内部触发 getShellResult + toInt 解析
    tempModels += homeRepository.detectDeveloperOptions() // <- 内部 Settings.Global.getInt
    tempModels += homeRepository.detectAdb()
    // ... 其余 detect* 同理, 任何一处抛异常即整页失败
}
```

```kotlin
// MountDataSource.kt:23-29 -- /proc/mounts 解析无容错
getShellResult(CMD_MOUNT).output.forEach {
    val columns = it.split(" ")
    if (columns.size == 6) {
        val mount = Mount(columns[0], columns[1], columns[2], columns[3],
            columns[4].toInt(),   // <- 非数字列直接 NumberFormatException
            columns[5].toInt())
        mounts.add(mount)
    }
}
```

```kotlin
// HomeRepository.kt:716-742 -- Settings 读取同样可能抛异常
fun detectDeveloperOptions(): MyModel {
    val isDeveloperOptionsDisabled = Settings.Global.getInt(
        MyApplication.instance.contentResolver,
        Settings.Global.DEVELOPMENT_SETTINGS_ENABLED,
        AndroidDataSource.SETTINGS_DISABLED
    ) == AndroidDataSource.SETTINGS_DISABLED
```

```kotlin
// BaseListFragment.kt:70-72 -- 协程无 CoroutineExceptionHandler, 异常直接崩溃
viewLifecycleOwner.lifecycleScope.launch {
    listViewModel.init(savedInstanceState)
}
```

异常冒泡链:`collectModels -> init -> lifecycleScope.launch`(无 catch)-> **未捕获协程异常 -> 应用崩溃**; 下拉刷新路径([BaseListFragment.kt](app/src/main/java/net/imknown/android/forefrontinfo/ui/base/list/BaseListFragment.kt), L103-L108) 同样无保护.

**改法示意:** 逐项隔离 + 解析容错.

```kotlin
// HomeViewModel: 单点失败不影响整页
private suspend fun <T> safeDetect(block: suspend () -> T?): T? = try {
    block()
} catch (e: Exception) {
    if (BuildConfig.DEBUG) {
        e.printStackTrace()
    }
    null
}

// 调用处: 失败返回 null, 跳过该项
tempModels += safeDetect { homeRepository.detectSar() }?.let(::listOf).orEmpty()
```

```kotlin
// MountDataSource: toInt -> toIntOrNull, 异常行跳过
if (columns.size == 6) {
    val dummy0 = columns[4].toIntOrNull()
        ?: return@forEach
    val dummy1 = columns[5].toIntOrNull()
        ?: return@forEach
    mounts.add(Mount(columns[0], columns[1], columns[2], columns[3], dummy0, dummy1))
}
```

### P2

#### 6. [UDF] payload 按 `lastIndex` 硬编码定位目标行

问题: 假定"最后一个模型 = outdated target SDK 行", 检测失败或缺行时会误改最后一行.

```kotlin
// HomeViewModel.kt:180 -- 按位置定位目标行
myModels.last().detail = withContext(Dispatchers.Default) {
    homeRepository.getOutdatedTargetSdkVersionApkModel(lld).detail
}
```

```kotlin
// HomeFragment.kt:46 -- 通知刷新也按同一位置
myAdapter.notifyItemChanged(models.lastIndex, MyAdapter.PAYLOAD_DETAILS)
```

**改法示意:** 按标题或类型定位, 废弃位置假设.

```kotlin
// 按标题定位
val targetIndex = list.indexOfFirst {
    it.title == MyApplication.getMyString(R.string.outdated_target_sdk_apk_title)
}
if (targetIndex == -1) {
    return   // 找不到就不改
}
updateModelDetail(targetIndex, newDetail)

// 更稳的做法: MyModel 增加 type 字段, 按类型定位而非标题文案
```

#### 7. [UDF] 状态写入 API 未封装

问题:`setModels()` 是 public 的, 任何 Fragment 都能直接写状态, 写入入口没有收敛为密封事件.

```kotlin
// BaseListViewModel.kt:27-30
@MainThread
fun setModels(tempModels: List<MyModel>) {          // <- public 写入口
    modelsStateFlow.value = State.Done(tempModels)
}
```

**改法示意:** 写入口收窄为 `protected`, 与 #8 的 sealed interface 改造一起做(见 #8 改法).

#### 8. [UDF]`State.toValue()` 不安全强转

问题: 对 `NotInitialized` 调用 `toValue()` 直接 `ClassCastException`, 靠调用方手写判断兜底.

```kotlin
// StateExt.kt:4-9
sealed class State<out T> {
    data class Done<out T>(val value: T) : State<T>()
    data object NotInitialized : State<Nothing>()

    fun toValue() = (this as Done).value   // <- NotInitialized 上调用即崩溃
}
```

**改法示意:** sealed interface + `when` 穷尽, 删除 `toValue()`.

```kotlin
sealed interface State<out T> {
    data class Done<T>(val value: T) : State<T>
    data object NotInitialized : State<Nothing>
}

// BaseListViewModel: setModels 改 protected(配合 #7)
protected fun setModels(tempModels: List<MyModel>) { ... }

// BaseListFragment: when 穷尽替代 toValue()
when (val s = stateMyModels) {
    is State.NotInitialized -> return@collect
    is State.Done -> { val newModels = s.value; ... }
}
```

#### 9. [UDF] 全量与局部刷新策略混用

问题: 状态采集走全量 `notifyDataSetChanged`, payload 走局部 `notifyItemChanged`, 两条传播路径不统一.

```kotlin
// BaseListFragment.kt:59-64 -- 全量
val myModels = myAdapter.myModels
val newModels = stateMyModels.toValue()
myModels.clear()
myModels.addAll(newModels)
myAdapter.notifyDataSetChanged()
```

```kotlin
// HomeFragment.kt:46 -- 局部
myAdapter.notifyItemChanged(models.lastIndex, MyAdapter.PAYLOAD_DETAILS)
```

**改法示意:** 引入 `ListAdapter` + DiffUtil, 统一走 `submitList`.

```kotlin
class MyAdapter : ListAdapter<MyModel, MyViewHolder>(Diff) {
    companion object {
        val Diff = object : DiffUtil.ItemCallback<MyModel>() {
            override fun areItemsTheSame(a: MyModel, b: MyModel) = a.title == b.title
            override fun areContentsTheSame(a: MyModel, b: MyModel) = a == b
        }
    }
}

// collect 处: submitList(newModels) 替代 clear+addAll+notifyDataSetChanged
// payload 更新后 StateFlow 重发射 -> submitList 自动局部 diff, 无需手动 notifyItemChanged
```

#### 10. [UDF] 设置读取跨越三层, 无统一网关

问题: 同一个"设置"被 View / ViewModel / Repository 三层各自直读 `SharedPreferences`.

```kotlin
// BaseListFragment.kt:42-43 -- View 层
val scrollBarMode = MyApplication.sharedPreferences.getString(scrollBarModeKey, null)
```

```kotlin
// HomeViewModel.kt:44-46 -- ViewModel 层
val allowNetwork = MyApplication.sharedPreferences.getBoolean(
    MyApplication.getMyString(R.string.function_allow_network_data_key), false
)
```

```kotlin
// HomeRepository.kt:1127-1130 -- Repository 层
val shouldOrderByPackageNameFirst = MyApplication.sharedPreferences.getBoolean(
    MyApplication.getMyString(R.string.function_outdated_target_order_by_package_name_first_key),
    false
)
```

**改法示意:** 经 `SettingsViewModel` / `SettingsRepository` 收口, 各层不再直读.

```kotlin
class SettingsViewModel(...) : BaseViewModel() {
    val scrollBarMode: StateFlow<String?> = MutableStateFlow(
        settingsRepository.getScrollBarMode()
    )
    fun setScrollBarMode(value: String?) {   // Preference 变更回调调用
        settingsRepository.putScrollBarMode(value)
        scrollBarMode.value = value
    }
}

// 消费方: collect scrollBarMode(替代 SharedPreferences 直读 + SharedFlow 双通道)
// HomeViewModel 的 allowNetwork, HomeRepository 的排序开关同理收口到 SettingsRepository
```

#### 11. [UDF] companion 级 SharedFlow 事件总线

问题: 事件挂在 companion object 上, 成为应用级广播, 与状态驱动相悖.

```kotlin
// SettingsViewModel.kt:38-43
companion object {
    val scrollBarModeChangedSharedFlow: SharedFlow<String?>
        field = MutableSharedFlow()
    val outdatedOrderChangedSharedFlow: SharedFlow<Unit>
        field = MutableSharedFlow()
}
```

**改法示意:** 与 #10 / #12 一并修 -- 广播收敛为 ViewModel 状态(`scrollBarMode: StateFlow`, 见 #10 改法);`outdatedOrderChangedSharedFlow` 同理改为状态或按需重查, 消除 companion 级旁路.

#### 12. [SSOT] 设置双通道

问题: scrollBar 模式的"值"存于 SharedPreferences, 同时又经 SharedFlow 广播同一事实, 两条通路.

```kotlin
// SettingsFragment.kt:92-97 -- 变更时: 本地应用 + 广播事件
scrollBarModePref?.setOnPreferenceChangeListener { preference, newValue ->
    val scrollBarMode = newValue as? String
    listView.setScrollBarMode(scrollBarMode)
    settingsViewModel.emitScrollBarModeChangedSharedFlow(scrollBarMode)   // <- 事件副本
    true
}
```

```kotlin
// BaseListFragment.kt:42-49 -- 消费方: SharedPreferences 直读 + SharedFlow 收集并存
val scrollBarMode = MyApplication.sharedPreferences.getString(scrollBarModeKey, null)  // 路 1
binding.recyclerView.setScrollBarMode(scrollBarMode)
viewLifecycleOwner.lifecycleScope.launch {
    SettingsViewModel.scrollBarModeChangedSharedFlow.flowWithLifecycle(...).collect {  // 路 2
        binding.recyclerView.setScrollBarMode(it)
    }
}
```

**改法示意:** 单一状态通道(见 #10 改法): 写侧只更新 `scrollBarMode: StateFlow`, 读侧只 collect 该 flow, 删除 SharedPreferences 直读与 SharedFlow 广播.

#### 13. [SSOT]`Build.ID` 双渲染(同类事实两条代码路径)

问题: 同一事实 `Build.ID` 两套渲染逻辑, 改动需两处同步.

```kotlin
// HomeRepository.kt:174-176 -- Home 页
fun detectBuildId(lld: Lld?): MyModel {
    val buildIdResult = Build.ID
        ?: "" // Fix weird R8 NPE on Android 6 only
```

```kotlin
// RomDataSource.kt:14 -- Others 页
fun getId(): String = Build.ID
```

**改法示意:** 抽共享渲染函数, 两页复用.

```kotlin
// 抽共享函数(ui/common 或 base)
fun buildIdToMyModel(lld: Lld?): MyModel { ... }

// HomeRepository.detectBuildId 与 OthersRepository 的 build id 渲染均改为调用它
```

#### 14. [SSOT] 属性键常量分散三文件, 无单一"属性字典"

问题: 属性键常量分布在三个文件, 新增属性没有权威清单.

```kotlin
// AndroidDataSource.kt -- home 模块集中定义
const val PROP_AB_UPDATE = "ro.build.ab_update"
const val PROP_SLOT_SUFFIX = "ro.boot.slot_suffix"
const val PROP_DYNAMIC_PARTITIONS = "ro.boot.dynamic_partitions"
```

```kotlin
// ArchitectureDataSource.kt:21 -- others 模块自行定义
private const val PROP_RO_PRODUCT_CPU_ABI = "ro.product.cpu.abi"
```

```kotlin
// FingerprintDataSource.kt:9 -- others 模块自行定义
private const val PROP_PREVIEW_SDK_FINGERPRINT = "ro.build.version.preview_sdk_fingerprint"
```

**改法示意:** 收拢到单一常量文件, 各模块引用.

```kotlin
// base 模块新建 AndroidProperties.kt
object AndroidProperties {
    const val AB_UPDATE = "ro.build.ab_update"
    const val SLOT_SUFFIX = "ro.boot.slot_suffix"
    const val PRODUCT_CPU_ABI = "ro.product.cpu.abi"
    const val PREVIEW_SDK_FINGERPRINT = "ro.build.version.preview_sdk_fingerprint"
    // ... 其余键全部收拢
}
// AndroidDataSource / ArchitectureDataSource / FingerprintDataSource 改为引用
```

### P3

#### 15. [UDF]`MainViewModel.lastId` 非响应式

问题: 普通 `var` + `SavedStateHandle` 双写, View 同步读取, 不是 StateFlow.

```kotlin
// MainViewModel.kt:14-20
@IdRes
var lastId = getSavedStateLastId()                      // <- 可写公共字段

fun setSavedStateLastId(@IdRes id: Int) {
    lastId = id
    savedStateHandle[SAVED_STATE_HANDLE_KEY_LAST_ID] = id   // <- 双份拷贝
}
```

```kotlin
// MainActivity.kt:92 / 111 -- View 同步读, 同步写
val lastId = mainViewModel.lastId
...
mainViewModel.setSavedStateLastId(selectedId)
```

**改法示意:** `SavedStateHandle.getStateFlow` 即天然 StateFlow, 消除双份拷贝.

```kotlin
class MainViewModel(private val savedStateHandle: SavedStateHandle) : ViewModel() {
    val lastId: StateFlow<Int> =
        savedStateHandle.getStateFlow(SAVED_STATE_HANDLE_KEY_LAST_ID, R.id.navigation_home)

    fun setSavedStateLastId(@IdRes id: Int) {
        savedStateHandle[SAVED_STATE_HANDLE_KEY_LAST_ID] = id
    }
}
// MainActivity: 同步读改为 collect lastId(或保留读, 字段收敛为 flow)
```

#### 17. [SSOT]`MainViewModel.lastId` 双份存储

问题: VM 字段与 SavedStateHandle 各存一份(SavedStateHandle 为持久层, 属常见模式, 但仍是两份拷贝), 代码见 #15.

**改法示意:** 同 #15 -- 字段收敛为 `savedStateHandle.getStateFlow(...)`, 单份真相.

#### 18. [SSOT] 查询层混入表示层文案

问题: 查询失败兜底返回**本地化 UI 文案**, 数据层无法区分"属性不存在"与"不支持";`getBooleanProperty` 失败静默返回 false.

```kotlin
// PropertyExt.kt:9-24
fun getStringProperty(
    key: String, condition: Boolean = true
): String {
    val notSupport = MyApplication.getMyString(R.string.result_not_supported)  // <- 数据层产出 UI 文案
    return if (condition) {
        try {
            val default = MyApplication.getMyString(R.string.build_not_filled)
            PropertyManager.instance.getStringOrThrow(key, default)
        } catch (e: Exception) {
            Log.w("getStringProperty", "$key: ${e.fullMessage}")
            notSupport
        }
    } else {
        notSupport
    }
}

fun getBooleanProperty(key: String, condition: Boolean = true) = if (condition) {
    try {
        PropertyManager.instance.getBooleanOrThrow(key, false)
    } catch (e: Exception) {
        Log.w("getBooleanProperty", "$key: ${e.fullMessage}")
        false   // <- 失败静默返回 false, 掩盖错误
    }
} else {
    false
}
```

**改法示意:** 数据层返回 null/哨兵, 文案翻译上移到 UI 层.

```kotlin
fun getStringPropertyOrNull(key: String, condition: Boolean = true): String? =
    if (condition) {
        try {
            PropertyManager.instance.getStringOrThrow(key, "")
        } catch (e: Exception) {
            null
        }
    } else {
        null
    }

// UI 层统一翻译 null -> 本地化文案
fun String?.orNotSupported() = this ?: MyApplication.getMyString(R.string.result_not_supported)
```

#### 19. [SSOT] 模型层直接产出展示文案

问题: 空值被翻译成 `build_not_filled` 文案, 原始值丢失, 数据层无法区分"值为空"与"已翻译".

```kotlin
// MyModelExt.kt:16-23
fun toTranslatedDetailMyModel(title: String, detail: String?): MyModel {
    val translatedDetail = if (detail.isNullOrEmpty()) {
        MyApplication.getMyString(R.string.build_not_filled)   // <- 空值即翻译, 原始值丢失
    } else {
        detail
    }
    return MyModel(title, translatedDetail)
}
```

**改法示意:** `MyModel.detail` 允许 null(保留原始值), 展示层负责翻译空值(`orNotSupported()`, 见 #18 改法).

#### 20. [SSOT] 可变全局单例(健壮性)

问题:`lateinit var` 单例运行期可被替换, 初始化前访问即崩.

```kotlin
// PropertyManager.kt:3-7 / ShellManager.kt:3-7
class PropertyManager(property: IProperty) : IProperty by property {
    companion object {
        lateinit var instance: PropertyManager   // <- lateinit var, 初始化前访问抛 UninitializedPropertyAccessException
    }
}
```

```kotlin
// MyApplication.kt:101-103 -- 初始化点
ShellManager.instance = ShellManager(ShellLibSu)
PropertyManager.instance = PropertyManager(PropertyDefault)
```

**改法示意:** 改不可变单例(`object` + lazy delegate).

```kotlin
object PropertyManager {
    private val delegate: IProperty by lazy { PropertyDefault }
    fun getStringOrThrow(key: String, default: String) = delegate.getStringOrThrow(key, default)
}
// ShellManager 同理
```

#### 21. [SSOT] 反射调用隐藏 API(健壮性)

问题: 反射调用隐藏类 `android.os.SystemProperties`, 不保证跨 Android 版本稳定.

```kotlin
// PropertyDefault.kt:7-18
@SuppressLint("PrivateApi")
object PropertyDefault : IProperty {
    private val systemPropertiesClass = Class.forName("android.os.SystemProperties")  // <- 隐藏 API 反射

    override fun getStringOrThrow(key: String, default: String): String =
        systemPropertiesClass.getDeclaredMethod(
            "get", String::class.java, String::class.java
        ).invoke(null, key, default) as String
}
```

**改法示意:** 加 SDK 版本守卫与降级路径.

```kotlin
object PropertyDefault : IProperty {
    override fun getStringOrThrow(key: String, default: String): String =
        if (Build.VERSION.SDK_INT < 30) {
            /* 反射路径(现状) */
        } else {
            /* 公共 / 镜像 API 降级路径 */
        }
}
```

#### 22. [健壮性] 阻塞 IO 全部跑在 `Dispatchers.Default`

问题: shell 命令(`Shell.cmd().exec()` 阻塞), 反射, 文件解析都在 CPU 绑定线程池执行, 慢设备(su 弹窗 / 权限等待) 会挤占 CPU 线程.

```kotlin
// HomeViewModel.kt:133-160
withContext(Dispatchers.Default) {          // <- CPU 池上做阻塞 IO
    tempModels += homeRepository.detectMode(lld, errorMessage, modeResId)
}
withContext(Dispatchers.Default) {
    tempModels += homeRepository.detectAb()   // <- 内部 Shell.cmd().exec() 阻塞
    tempModels += homeRepository.detectSar()  // <- 内部 cat /proc/mounts + 解析
    tempModels += homeRepository.detectKernel(lld)
    // ...
}
```

**改法示意:** 阻塞 IO 改 `Dispatchers.IO`, 纯计算保留 Default.

```kotlin
withContext(Dispatchers.IO) {
    tempModels += homeRepository.detectAb()    // shell
    tempModels += homeRepository.detectSar()   // 文件 + 解析
    tempModels += homeRepository.detectKernel(lld)
}
```

#### 23. [SSOT] 每次网络请求新建 `HttpClient(OkHttp)`

问题: 每次进 Home 页 / 下拉刷新都重建 client, OkHttp 连接池 / 线程池复用失效; 无显式超时.

```kotlin
// LldDataSource.kt:43-117
suspend fun fetchOnlineLldJsonStringOrThrow(): String {
    ...
    val client = HttpClient(OkHttp) {          // <- 每次请求新建, 连接池/线程池随之销毁
        engine { config { ... } }
        ...
    }
    val response: HttpResponse = client.get(url) { ... }
    return client.use {
        response.body()
    }
}
```

**改法示意:** client 提为单例懒加载 + 显式超时.

```kotlin
private val client by lazy {
    HttpClient(OkHttp) {
        install(HttpTimeout) {
            requestTimeoutMillis = 15_000
            connectTimeoutMillis = 10_000
        }
        engine { config { ... } }   // 原 EventListener / ProxySelector 保留
    }
}

suspend fun fetchOnlineLldJsonStringOrThrow(): String =
    client.get("https://$urlPrefixLldJson/...") { headers { ... } }.body()
```

## ⏸ 暂缓

> 以下问题暂不处理: #4 内核版本双实现 / #16 依赖在 View 层组装 / #24 零测试保护.

#### 4. [SSOT] 内核版本双实现(同一事实两条路径)

问题: 同一"内核版本"在 Home 页与 Others 页用不同来源, 不同格式获取, 可能展示不一致.

```kotlin
// HomeRepository.kt:319-321 -- Home 页: 读 os.version 系统属性
fun detectKernel(lld: Lld?): MyModel {
    val linuxVersionString = System.getProperty(AndroidDataSource.SYSTEM_PROPERTY_LINUX_VERSION)  // "os.version"
    val linuxVersion = Version(linuxVersionString)
```

```kotlin
// KernelDataSource.kt:7-13 -- Others 页: 跑 shell 命令
private const val CMD_KERNEL_VERBOSE = "cat /proc/version"
private const val CMD_KERNEL_ALL = "uname -a"

fun getKernelVersion() = getShellResult(CMD_KERNEL_VERBOSE)
fun getKernelAll() = getShellResult(CMD_KERNEL_ALL)
```

**改法示意:** 抽共享 KernelDataSource, 两页复用同一查询与渲染.

```kotlin
// ① 共享 KernelDataSource(放 base 或 ui/common)
class KernelDataSource {
    fun getKernelVersion(): String? = getShellResult(CMD_KERNEL_VERBOSE).output.firstOrNull()
    fun getKernelAll(): String? = getShellResult(CMD_KERNEL_ALL).output.firstOrNull()
}

// ② HomeRepository.detectKernel 改为复用(os.version 降级为兜底)
fun detectKernel(lld: Lld?): MyModel {
    val linuxVersionString = kernelDataSource.getKernelVersion()
        ?: System.getProperty(AndroidDataSource.SYSTEM_PROPERTY_LINUX_VERSION)
    ...
}

// ③ OthersRepository.getKernelVersion 同样改用共享 KernelDataSource
```

#### 16. [UDF] 依赖在 View 层手工组装, 无组合根

问题: Fragment 在 `extrasProducer` 里手工 `new` Repository, 每个 Fragment 实例重建依赖图.

```kotlin
// HomeFragment.kt:24-36
override val listViewModel by viewModels<HomeViewModel>(
    extrasProducer = {
        MutableCreationExtras(defaultViewModelCreationExtras).apply {
            val repository = HomeRepository(
                LldDataSource(), MountDataSource(), AppInfoDataSource()   // <- View 层 new 依赖
            )
            this[HomeViewModel.MY_REPOSITORY_KEY] = repository
        }
    },
    factoryProducer = { HomeViewModel.Factory }
)
```

**改法示意:** 引入组合根(Application 级 ServiceLocator).

```kotlin
object ServiceLocator {
    val homeRepository by lazy { HomeRepository(LldDataSource(), MountDataSource(), AppInfoDataSource()) }
    val othersRepository by lazy { OthersRepository(BasicDataSource(), ...) }
}

// Fragment: extrasProducer 改从 ServiceLocator 取
val repository = ServiceLocator.homeRepository
this[HomeViewModel.MY_REPOSITORY_KEY] = repository
```

#### 24. [工程] 检测逻辑零测试保护

问题:`Version` 解析, SAR 判定, build id 比较等纯逻辑没有任何单元测试, 测试目录仍是模板.

```kotlin
// ExampleUnitTest.kt -- 模板测试, 未替换
class ExampleUnitTest {
    @Test
    fun addition_isCorrect() {
        assertEquals(4, 2 + 2)
    }
}
```

**改法示意:** 为纯逻辑补单测, 护航 P0/P1 重构.

```kotlin
class VersionTest {
    @Test
    fun `parse valid kernel version`() {
        assertEquals("5.15.94", Version("5.15.94-android13-8-...").majorMinorPatch())
    }

    @Test
    fun `sar legacy mount detection`() { ... }

    @Test
    fun `build id cts format check`() { ... }
}
```


