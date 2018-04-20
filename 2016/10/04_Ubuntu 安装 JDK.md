**注意! 本文部分内容的可用性, 有待进一步核实!**

# 安装
## PPA
### OracleJDK
- https://launchpad.net/~webupd8team/+archive/ubuntu/java

``` bash
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-installer
```

### OpenJDK
- https://launchpad.net/~openjdk-r/+archive/ubuntu/ppa

``` bash
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jdk
```
  
## 官网下载 (适合自己折腾)
### OracleJDK
http://www.oracle.com/technetwork/java/javase/downloads/index.html

### OpenJDK
http://openjdk.java.net/install/


# 配置
## OracleJDK
- 配置环境变量
  - 查看 已安装的版本 (还会包括 `OpenJDK`)  
  `update-java-alternatives -l`
  - 设置成 默认版本  
  `sudo apt-get install oracle-java8-set-default`
  - 切换成 其他版本  
  `sudo update-java-alternatives -s java-7-oracle`

## OpenJDK
- http://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts

## 通用
### 配置方法1 (仿 PPA)
- https://stackoverflow.com/a/49507161

``` bash
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

### 配置方法2 (不推荐)
- https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/10/14_Ubuntu%2016%20配置%20ADB%20环境变量.md#手动方式

最下面加入
``` bash
export JAVA_HOME="/your_unzip_location"
export PATH=$JAVA_HOME/bin:$PATH
```


## 验证是否配置成功
先刷新环境变:  
https://github.com/imknown/IMKDevelopmentDaily/blob/master/2016/10/14_Ubuntu%2016%20配置%20ADB%20环境变量.md#刷新生效

然后执行:
``` bash
echo $JAVA_HOME
echo $PATH
java -version
javac -version
```


# 卸载 (参考)
``` bash
# openjdk
sudo apt purge openjdk*

# oracle jdk
sudo rm /var/lib/dpkg/info/oracle-j*
sudo apt purge oracle-j*
sudo rm /etc/apt/sources.list.d/*java*
sudo apt update
```
