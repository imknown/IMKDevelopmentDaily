``` xml
<EditText
    android:id="@+id/et"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:hint="数字"
    android:inputType="numberDecimal" />
```

``` java
public class MainActivity extends Activity {

    EditText et;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        et = (EditText) findViewById(R.id.et);

        et.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                et.removeTextChangedListener(this);

                double number = Double.parseDouble(s.toString());
                String sFormat = new DecimalFormat("#.00").format(number);
                et.setText(sFormat);

                et.addTextChangedListener(this);
            }

            @Override
            public void afterTextChanged(Editable s) {
            }
        });
    }
}
```

参考 http://stackoverflow.com/questions/9385081/how-can-i-change-the-edittext-text-without-triggering-the-text-watcher
