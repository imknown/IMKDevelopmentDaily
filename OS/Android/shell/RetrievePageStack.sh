#!/bin/sh

readonly ANDROID_VERSION_CODE_11="30"

printCurrent() {
  androidVersionCode=$(adb shell getprop ro.build.version.sdk)

  if [ "$androidVersionCode" -ge $ANDROID_VERSION_CODE_11 ]; then
    adb shell dumpsys window | grep "mFocusedApp"
    adb shell dumpsys window windows | grep mObscuringWindow
  else
    adb shell dumpsys window windows | grep "mFocusedApp"
    adb shell dumpsys window windows | grep "mCurrentFocus"
  fi
}

printStack() {
  adb shell dumpsys activity "$name" \
    | grep \
    -e "pid=" \
    -e "Local Activity" \
    -e "Local FragmentActivity" \
    -e " FragmentManager{" \
    -e "Active Fragments" \
    -e "Added Fragments" \
    -e "  #"
}

printAll() {
  echo =============================
  echo
  printCurrent
  echo
  printStack
}

empty() {
  printf "\33c\e[3J"
}

printDiff() {
  isSilent=$1
  mode=""
  case $isSilent in
    0) mode="--left-column";;
    1) mode="-s --suppress-common-lines";;
  esac
  diff -y -W320 $mode TempLastStack.log TempCurrentStack.log
}

compare() {
  mv TempCurrentStack.log TempLastStack.log
  printAll > TempCurrentStack.log
  printDiff 0
  echo
  echo "🟥🟩️🟥🟩️🟥 Differences 🟥🟩️🟥🟩️🟥"
  printDiff 1
}

cd "${0%/*}" || exit
mkdir .DumpsysLogs
cd .DumpsysLogs || exit

empty
read -r -p "Enter package name or process name: " name
echo

:> TempLastStack.log
printAll > TempCurrentStack.log
cat TempCurrentStack.log

while echo && read -r -p "Press: [e] empty, [c] compare, [f] full ➡️  " -n1 ; do
  echo
  echo
  case "$REPLY" in
    e) empty;;
    c) compare;;
    f) printAll;;
  esac
done

echo
