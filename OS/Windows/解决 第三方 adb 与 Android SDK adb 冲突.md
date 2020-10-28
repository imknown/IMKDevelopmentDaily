以 `夜神模拟器` 为例:

1. 确保 环境变量 `ANDROID_SDK_ROOT`, `Path` 的值 正确:
   - **ANDROID_SDK_ROOT** = <SDK 根目录>
   - **ANDROID_HOME** = <SDK 根目录>
   - **Path** = %Path%;%ANDROID_SDK_ROOT%\platform-tools;%ANDROID_SDK_ROOT%\build-tools\\&lt;Version&gt;;

2. 找到安装目录下的 `...\Nox\bin\`, 删除以下文件 (升级 `夜神` 之后, 需要重新执行此步骤)
   - aapt.exe
   - adb.exe
   - nox_adb.exe
   - AdbWinApi.dll
   - AdbWinUsbApi.dll
   - libwinpthread-1.dll

3. 创建 nox_adb.exe **硬链接** (升级 `platform-tools` 之后, 需要重新执行此步骤)
``` cmd
cd /d %ANDROID_SDK_ROOT%\platform-tools

Rem 以下 三选一

Rem 使用 PowerShell
mklink /H nox_adb.exe adb.exe

Rem 使用 CMD/命令提示符
cmd /c mklink /H nox_adb.exe adb.exe

Rem 手动复制
Rem 复制 adb.exe, 并粘贴 为 nox_adb.exe
```
