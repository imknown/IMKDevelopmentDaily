# AAB 重命名的问题
## 问题原因
> - https://android.googlesource.com/platform/tools/base/+/studio-master-dev/build-system/gradle-core/src/main/java/com/android/build/gradle/api/ApkVariantOutput.java#104
> - https://android.googlesource.com/platform/tools/base/+/refs/tags/studio-4.1.0/build-system/gradle-core/src/main/java/com/android/build/gradle/api/ApkVariantOutput.java#104

目前 (`AGP 4.1.0`) 下述方法,  
只能修改 `Gradle Assemble Task` 生成的 `APK` 的文件名,  
无法修改 `Gradle Bundle Task` 生成的 `AAB` 的文件名:

``` gradle
android {
    def fileName = "Foo_${versionName}_${versionCode}_${date}_${buildVersion}"

    applicationVariants.all { variant ->
        variant.outputs.each { output ->
            // AGP 2.x 及其之前 的写法
            // output.outputFile = new File(output.outputFile.parent, fileName)

            // AGP 3.x 及其之后 的写法
            outputFileName = fileName
        }
    }
}
```

## 修改方案
要处理 `APK` 和 `AAB`, 最简单的方式 就是只用 `Gradle` 的 `archivesBaseName` 属性:
> https://docs.gradle.org/current/userguide/working_with_files.html#sec:archive_naming

`AGP 3.5.0+` 的版本, `APK` 和 `AAB` 的 文件名最后 会自动拼接 `-$flavorName-$buildTypeName.xxx`,  
所以, 此时没有必要 再手动拼接 `productFlavors` 或者 `buildTypes`.  
此外, 注意移除上面的 `outputFileName`, 不然 `APK` 的 `archivesBaseName` 会被覆盖.

``` gradle
android {
    def fileName = "Foo_${versionName}_${versionCode}_${date}_${buildVersion}"

    defaultConfig {
        archivesBaseName = fileName
    }
}
```

`AGP 3.4.2` 之类的老版本, `APK` 的 文件名最后 会自动拼接 "-$flavorName-$buildTypeName.apk", 而 `AAB` 不会.  
所以 `APK` 可以继续使用 `AGP` 的 `outputFileName` 覆盖此处.
``` gradle
android {
    def fileName = "Foo_${versionName}_${versionCode}_${date}_${buildVersion}"

    defaultConfig {
        archivesBaseName = fileName
    }

    applicationVariants.all { variant ->
        variant.outputs.all {
            def flavorName = variant.flavorName
            def flavorShortName = flavorName.capitalize().charAt(0)
            outputFileName = "${flavorShortName}_${fileName}.apk"
        }
    }   
}
```

如果 `AAB` 需要 `productFlavors` 或者 `buildTypes`, 则可以使用 `variantFilter`.  
(当然, 也可以在 `defaultConfig` 中 截取 `currentTaskName` 来实现 类似 `variant` 的效果, 但是比较麻烦)

``` gradle
android {
    def fileName = "Foo_%s_${versionName}_${versionCode}_${date}_${buildVersion}"

    variantFilter { variant ->
//        def currentTaskName = gradle.startParameter.taskNames[0]
//        def bundleTaskName = "bundle${variant.name.capitalize()}"
//        if (currentTaskName == bundleTaskName) {
            def flavorName = variant.flavors.name[0]
            def flavorShortName = flavorName.capitalize().charAt(0)
            archivesBaseName = sprintf fileName, flavorShortName
//        }
    }

    applicationVariants.all { variant ->
        variant.outputs.all {
            def flavorName = variant.flavorName
            def flavorShortName = flavorName.capitalize().charAt(0)
            outputFileName = sprintf "${fileName}.apk", flavorShortName
        }
    }  
}
```

### 其他方式
比如说 自定义 `Gradle Task`, 结合 命令行 或者 其他 I/O 方式等.  
但是相对较繁琐, 仅供参考, 提供思路.
> https://stackoverflow.com/questions/52508720/how-to-change-the-generated-filename-for-app-bundles-with-gradle
