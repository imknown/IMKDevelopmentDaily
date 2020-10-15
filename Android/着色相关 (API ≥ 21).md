> https://medium.com/@hanru.yeh/tips-for-drawablecompat-settint-under-api-21-1e62a32fc033  
> https://stackoverflow.com/questions/41588148/android-textview-drawabletint-on-pre-v23-devices/  
> https://stackoverflow.com/questions/29155463/drawable-tinting-for-api-21/  
> https://stackoverflow.com/questions/30938620/android-button-drawable-tint  
> https://gist.github.com/MRezaNasirloo/110310338c81ce1f90c8eb9a828b6c88

## XML 方式
``` xml
<TextView
    xmlns:tools="http://schemas.android.com/tools"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:textColor="@drawable/selector_tint"
    app:drawableEndCompat="@drawable/tri_white"
    app:drawableTint="@drawable/selector_tint"
    tools:text="12312312345" />
```

selector_tint.xml
``` xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:color="@color/color_101154209" android:state_pressed="true" />
    <item android:color="@color/color_text_255255255" />
</selector>
```

## 动态代码
``` java
// Drawable[] drawables = view.getCompoundDrawablesRelative();
Drawable drawable = ContextCompat.getDrawable(context, R.drawable.xxx);
Drawable wrappedDrawable = DrawableCompat.wrap(drawable);
// DrawableCompat.setTint(wrappedDrawable, ContextCompat.getColor(context, R.color.white));
Drawable mutableDrawable = wrappedDrawable.mutate();
DrawableCompat.setTint(mutableDrawable, ContextCompat.getColor(context, R.color.white));
mutableDrawable.invalidateSelf();
```

``` java
// Filter for pre Android 5
// Drawable[] drawables = view.getCompoundDrawablesRelative();
Drawable drawable = ContextCompat.getDrawable(context, R.drawable.xxx);
int textColor = getTextColors().getColorForState(EMPTY_STATE_SET, Color.WHITE);
drawable.setColorFilter(textColor, PorterDuff.Mode.SRC_ATOP);
```