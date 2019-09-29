以 `夜神模拟器` 为例:

1. 确保 环境变量 `ANDROID_SDK_ROOT`, `Path` 的值 正确:
   - **ANDROID_SDK_ROOT** = <SDK 根目录>
   - **ANDROID_HOME** = <SDK 根目录>
   - **Path** = %Path%;%ANDROID_SDK_ROOT%\platform-tools;%ANDROID_SDK_ROOT%\build-tools\\&lt;Version&gt;;

2. 找到安装目录下的 `...\Nox\bin\`, 删除一下文件 (建议先备份):
   - aapt.exe
   - adb.exe
   - nox_adb.exe
   - AdbWinApi.dll
   - AdbWinUsbApi.dll
   - libwinpthread-1.dll

3. 创建 nox_adb.exe **硬链接**
``` cmd
cd /d %ANDROID_SDK_ROOT%\platform-tools

REM PowerShell 请用 cmd /c mklink
mklink /H nox_adb.exe adb.exe
```
