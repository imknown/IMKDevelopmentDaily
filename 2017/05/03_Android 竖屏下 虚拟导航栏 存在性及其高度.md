# 是否存在
``` java
public static boolean isSoftNavigationBarAvailable() {
    boolean hasSoftwareKeys;

//    // 这个 在 OPPO R9m (Android 6) 返回 true, 但是 应该返回 false
//    int id = context.getResources().getIdentifier("config_showNavigationBar", "bool", "android");
//    hasSoftwareKeys = (id > 0 && context.getResources().getBoolean(id));

    WindowManager manager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
        Display d = manager.getDefaultDisplay();

        DisplayMetrics realDisplayMetrics = new DisplayMetrics();
        d.getRealMetrics(realDisplayMetrics);

        int realHeight = realDisplayMetrics.heightPixels;
        int realWidth = realDisplayMetrics.widthPixels;

        DisplayMetrics displayMetrics = new DisplayMetrics();
        d.getMetrics(displayMetrics);

        int displayHeight = displayMetrics.heightPixels;
        int displayWidth = displayMetrics.widthPixels;

        hasSoftwareKeys = (realWidth - displayWidth) > 0 || (realHeight - displayHeight) > 0;
    } else {
//        boolean hasMenuKey = ViewConfiguration.get(context).hasPermanentMenuKey();
        boolean hasBackKey = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_BACK);
        boolean hasHomeKey = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_HOME);
        hasSoftwareKeys = !(hasBackKey && hasHomeKey);
    }

    return hasSoftwareKeys;
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
