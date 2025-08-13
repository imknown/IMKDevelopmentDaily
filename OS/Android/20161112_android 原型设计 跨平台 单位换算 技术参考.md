# 概念
> 1. pixel density: https://wikipedia.org/wiki/Pixel_density  
   > PPI: https://wikipedia.org/wiki/Pixels_per_inch  
   > DPI: https://wikipedia.org/wiki/Dots_per_inch  
> 1. px: https://en.m.wikipedia.org/wiki/Pixel  
> 1. dip/dp: https://wikipedia.org/wiki/Device-independent_pixel  
> 1. Typography: https://wikipedia.org/wiki/Typography  
> 1. pt: https://wikipedia.org/wiki/Point_(typography)  
> 1. Windows Presentation Foundation: https://wikipedia.org/wiki/Windows_Presentation_Foundation  
> 1. https://m3.material.io/blog/device-metrics  

# 术语
物理:
1. 通常 不能 轻易改变.  
   有时称为 `硬件`.  
   反之称为 `软件` (由 `系统` 和 `用户` 共同决定, adb 中也称 `Override`).  
1. 通常 只影响 用户的 `直观视觉感受`.  
1. 通常 不会 直接影响到 开发者 进行 `UI 的适配`.

| 缩写 | 全称 | 中文 | 是否可变 |
| ---- | ---- | ---- | ---- |
| in 或者 `″` | inch | 英寸 | 不可变 |
| pt (typography) | point (typography) | 点 / 磅 (印刷排版) | 不可变, 等于 1/72 inch |

| 缩写 | 全称 | 中文 | 是否可变 |
| ---- | ---- | ---- | ---- |
| "physical" px | "physical" pixel | "物理" 像素 | 不可变 |
| logical px | logical pixel | 逻辑像素 | 可变, 包括 pt (iOS), dp/dip, sp 等 |
| pt (iOS) | point (iOS) | 点 (iOS) | 可变 |
| dp / dip | device-independent pixel | 设备无关像素 | 可变 |
| sp | scale-independent pixel | 比例无关像素 | 可变 |

| 缩写 | 全称 | 中文 | 是否可变 |
| ---- | ---- | ---- | ---- |
| - | density | 密度 | 可变 |
| - | pixel density | 像素密度 | 可变 |

| 缩写 | 全称 | 中文 | 是否可变 |
| ---- | ---- | ---- | ---- |
| DPS | device physical size | 设备物理尺寸 | 可变, 单位: 英寸 |

| 缩写 | 全称 | 中文 | 是否可变 |
| ---- | ---- | ---- | ---- |
| r | resolution | 分辨率 | 可变, 单位 px |
| rw | resolution width | 分辨率 宽 | 可变, 单位 px |
| rh | resolution height | 分辨率 高 | 可变, 单位 px |
| pr | physical resolution | 物理分辨率 | 可变, 单位 px |
| lr | logical resolution | 逻辑分辨率 | 可变, 单位 px |
| physical PPI | physical pixels per inch | 物理 每英寸像素数 | 可变 |
| logical PPI | logical pixels per inch | 逻辑 每英寸像素数 | 可变, 跟 DPI 异曲同工, 殊途同归 |
| DPI | dots per inch | 每英寸点数 | 可变, 由 ROM / 用户 决定 |
| sw | smallest width | 最小宽度 | 可变, 单位 dp |

| 缩写 | 全称 | 中文 | 是否可变 |
| ---- | ---- | ---- | ---- |
| TSS | text size scale | 文本字号比例 | 可变, 由 ROM / 用户 决定 |

# DPI
## 各平台 默认 1:1 DPI
| 平台 | 值 |
| :--: | ---: |
| Android | 160 |
| iOS | 163 |
| Windows | 96 |
| Ubuntu | 96 |
| Mac OS X / macOS | 72 |

## Android DPI
| 缩写 | 值 | 密度 |
| ---: | ---: | ---- |
| ldpi | ~120 | ~¾ |
| mdpi | ~160 | ~1 |
| tvdpi | ~213 | ~1⅓ |
| hdpi | ~240 | ~1½ |
| xhdpi | ~320 | ~2 |
| xxhdpi | ~480 | ~3 |
| xxxhdpi | ~640 | ~4 |

# 运算
```
diagonal = √‾(rw² + rh²) px
PPI = diagonal / DPS
density = DPI / mdpi
1 dp = 1 px × density
1 sp = 1 dp × TSS
```

```
sw = rw / density = rw × mdpi / DPI
rw = density × sw = DPI × sw / mdpi
DPI = density × mdpi = rw × mdpi / sw
density = DPI / mdpi = rw / sw
```

例如
1. physical DPI = 320  
   → physical density = 2
1. logical  DPI = 300  
   → logical density = 1.875
1. pr 720 (px) x 1280 (px)  
   → physical sw = 720 / 2 = 360 (dp)
1. lr 740 (px) x 1300 (px)  
   → logical sw = 740 / 1.875 = 394⅔ (dp)

## 小例子
| Model         | DPS   | PPI    | DPI    | density | r px        | r dp            |
| ------------- | ----- | ------ | ------:| ------- | ----------- | --------------- |
| Pixel XL      | 5.5″  | 534.04 | 560dpi | 3.5     | 1440 x 2560 | 411.43 x 731.43 |
| Pixel         | 5″    | 440.58 | 420dpi | 3       | 1080 x 1920 | 360    x 640    |
| Nexus 6P      | 5.7″  | 515.30 | 560dpi | 3.5     | 1440 x 2560 | 411.43 x 731.43 |
| Nexus 5X      | 5.2″  | 423.64 | 420dpi | 2.625   | 1080 x 1920 | 411.43 x 731.43 |
| Nexus 6       | 5.96″ | 492.82 | 560dpi | 3.5     | 1440 x 2560 | 411.43 x 731.43 |
| Nexus 5       | 4.95″ | 445.03 | xxhdpi | 3       | 1080 x 1920 | 360    x 640    |
| Nexus 4       | 4.7″  | 317.60 |  xhdpi | 2       |  768 x 1280 | 384    x 640    |
| Galaxy Nexus  | 4.65″ | 315.83 |  xhdpi | 2       |  720 x 1280 | 360    x 640    |
| Nexus S       | 4″    | 223.24 |   hdpi | 2       |  480 x  800 | 240    x 400    |
| Nexus One     | 3.7″  | 252.15 |   hdpi | 2       |  480 x  800 | 240    x 400    |

| Model         | DPS    | PPI    | DPI    | density | r px        | r dp       |
| ------------- | ------ | ------ | ------:| ------- | ----------- | ---------- |
| Nexus C       | 9.94″  | 314.84 |  xhdpi | 2       | 2560 x 1800 | 1280 x 900 |
| Nexus 9       | 8.86″  | 288.94 |  xhdpi | 2       | 1536 x 2048 | 768 x 1024 |
| Nexus 7       | 7.02″  | 323.45 |  xhdpi | 2       | 1200 x 1920 |  600 x 960 |
| Nexus 7(2012) | 7″     | 215.02 | tvhdpi | 1.333   |  800 x 1280 |  600 x 640 |
| Nexus 10      | 10.05″ | 300.39 |  xhdpi | 2       | 2560 x 1600 | 1280 x 800 |

# 常用命令
## 获取 显示的一些参数
``` shell
adb shell dumpsys display
```

## 修改 lr
``` shell
# 查询
adb shell wm size

# 设置
adb shell wm size 1080x1920

# 恢复
adb shell wm size reset
```

## 修改 DPI
``` shell
# 查询
adb shell wm density

# 设置
adb shell wm density 420

# 恢复
adb shell wm density reset
```

或者 修改 `build.prop` 然后 至少重启 `SystemUI`:
``` properties
ro.sf.lcd_density=420
```

## Android 7/8 启用 Freeform
``` shell
# 启用
adb shell settings put global enable_freeform_support 1
adb reboot

# 禁用
adb shell settings put global enable_freeform_support 0
adb reboot
```
