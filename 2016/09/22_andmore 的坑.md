`Eclipse` 出的 `Andmore` 安卓开发工具,  
因为 更换了 `包名`, 所以 并不直接兼容 ADT 项目,  
需要 人工修改 `.project` 和 `.classpath` 文件.

> .classpath  

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<classpath>
	<!-- Eclipse Google ADT start -->
	<classpathentry kind="con" path="com.android.ide.eclipse.adt.ANDROID_FRAMEWORK"/>
	<classpathentry exported="true" kind="con" path="com.android.ide.eclipse.adt.LIBRARIES"/>
	<classpathentry exported="true" kind="con" path="com.android.ide.eclipse.adt.DEPENDENCIES"/>
	<!-- Eclipse Google ADT end -->

	<!-- Eclipse Andmore start -->
	<classpathentry kind="con" path="org.eclipse.andmore.ANDROID_FRAMEWORK"/>
	<classpathentry exported="true" kind="con" path="org.eclipse.andmore.LIBRARIES"/>
	<classpathentry exported="true" kind="con" path="org.eclipse.andmore.DEPENDENCIES"/>
	<!-- Eclipse Andmore end -->

	<classpathentry kind="src" path=".apt_generated">
		<attributes>
			<attribute name="optional" value="true"/>
		</attributes>
	</classpathentry>
	<classpathentry kind="src" path="src"/>
	<classpathentry kind="src" path="gen"/>
	<classpathentry kind="output" path="bin/classes"/>
</classpath>
```

> .project  

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
	<name>Name Here</name>
	<comment></comment>
	<projects>
	</projects>
	<buildSpec>
		<!-- Eclipse Google ADT start -->
		<buildCommand>
			<name>com.android.ide.eclipse.adt.ResourceManagerBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>com.android.ide.eclipse.adt.PreCompilerBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>com.android.ide.eclipse.adt.ApkBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<!-- Eclipse Google ADT end -->

		<!-- Eclipse Andmore start -->
		<buildCommand>
			<name>org.eclipse.andmore.ResourceManagerBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.andmore.PreCompilerBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>org.eclipse.andmore.ApkBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<!-- Eclipse Andmore end -->
	</buildSpec>
	<natures>
		<nature>com.android.ide.eclipse.adt.AndroidNature</nature>
		<nature>org.eclipse.andmore.AndroidNature</nature>
		<nature>org.eclipse.jdt.core.javanature</nature>
	</natures>
</projectDescription>

```
