定义
``` java
ViewPager mMyViewPager;

private static class MyPagerAdapter extends PagerAdapter {
  // ...

  @Override
  public Object instantiateItem(ViewGroup view, final int position) {
    View itemView = ...; // new or inflate
    
    // ...
    
    itemView.setTag(position);
    
    view.add(itemView, 0);
    
    return itemView;
  }

  // ...
}
```

使用
``` java
View currentItemView = mMyViewPager.findViewWithTag(mMyViewPager.getCurrentItem());
```

# 参考
http://stackoverflow.com/a/11176510/2782426
