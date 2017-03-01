``` java
View contentView = LayoutInflater.from(MainActivity.this).inflate(R.layout.popup_layout, null);
popupWindow = new PopupWindow(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
popupWindow.setContentView(contentView);
popupWindow.setAnimationStyle(R.style.PopupAnimation);
popupWindow.setOutsideTouchable(true);
popupWindow.setTouchable(true);
popupWindow.setFocusable(true);
popupWindow.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
popupWindow.setOnDismissListener(new PopupWindow.OnDismissListener() {
    @Override
    public void onDismiss() {
    }
});

// contentView.setFocusable(true);
// contentView.setFocusableInTouchMode(true);
// contentView.setOnKeyListener(new OnKeyListener() {
//     @Override
//     public boolean onKey(View v, int keyCode, KeyEvent event) {
//         if (keyCode == KeyEvent.KEYCODE_BACK) {
//         }
//
//         return false;
//     }
// });
```

``` xml
<style name="PopupAnimation" parent="android:Animation">
    <item name="android:windowEnterAnimation">@android:anim/fade_in</item>
    <item name="android:windowExitAnimation">@android:anim/fade_out</item>
</style>
```
