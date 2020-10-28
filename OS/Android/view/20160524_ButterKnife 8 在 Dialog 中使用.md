[`ButterKnife`][ButterKnife] 出 `8.0.1` 了, 神作了...  
在 `AlertDialog` 里面 使用 [`ButterKnife`][ButterKnife] 的话, 需要使用:  

``` java
public MyDialog(Context context) {
  View viewRoot = inflater.inflate(context, layoutResId, null);
  ViewHolder holder = new ViewHolder();
  
  ButterKnife.bind(holder, viewRoot);
  
  super.setView(viewRoot);
}

...

class ViewHolder {
  @BindView(R.id.some_id)
  View view;
  
  ...
}
```

我的 [`AlertDialog`][supportV7AlertDialog] 暂时 导入的 `support.v7` 里面的 我记得, 明天具体看看.  

##### 2016-05-25 注:  
已验证, [`android.app.AlertDialog`][AlertDialog] 和 [`android.support.v7.app.AlertDialog`][supportV7AlertDialog] 都是可以的.  

[ButterKnife]: https://github.com/JakeWharton/butterknife
[AlertDialog]: https://developer.android.com/reference/android/app/AlertDialog.html
[supportV7AlertDialog]: https://developer.android.com/reference/android/support/v7/app/AlertDialog.html

##### 2016-05-31 注:  
看了 同事的代码, 发现 自己的实现 好 hacking...  
直接上代码:  
``` java
public class MyDialog extends Dialog {
  @BindView(R.id.some_id)
  View view;
  
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    
    ButterKnife.bind(this);
    
    setContentView(layoutResId);
  }
}
```
