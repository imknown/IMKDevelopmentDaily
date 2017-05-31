直接上代码:  

项目根目录 **新建** 的文件 `buildScriptConfig.gradle`
``` gradle
ext {
    androidStudioGradlePluginVersion = '2.3.2'
    // ...
}
```

项目根目录 `build.gradle` 文件
``` gradle
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    apply from: "buildScriptConfig.gradle"

    repositories {
        jcenter()
    }

    dependencies {
        classpath "com.android.tools.build:gradle:$androidStudioGradlePluginVersion"

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

// ...
```

### 注意
`apply` 方法 **必须** 写在 `buildscript` 方法内部 (写在 `dependencies` 方法中也可以)...  
当然, 不能写在 `classpath "com.android.tools.build:gradle:$androidStudioGradlePluginVersion"` 下面...
