# 是否存在
``` java
public static boolean isSoftNavigationBarAvailable() {
    int id = context.getResources().getIdentifier("config_showNavigationBar", "bool", "android");
    boolean has1 = (id > 0 && context.getResources().getBoolean(id));

    boolean hasBackKey = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_BACK);
    boolean hasHomeKey = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_HOME);
    boolean has2 = (!(hasBackKey && hasHomeKey));

    return has1 || has2;
}
```

# 高度
``` java
public static int getSoftNavigationBarHeight(Context context) {
    int result = 0;

    int resourceId = context.getResources().getIdentifier("navigation_bar_height", "dimen", "android");

    if (resourceId > 0) {
        result = context.getResources().getDimensionPixelSize(resourceId);
    }

    return result;
}
```

# 参看
- http://stackoverflow.com/a/28983720/2782426
