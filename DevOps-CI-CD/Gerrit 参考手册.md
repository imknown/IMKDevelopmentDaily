# 运维: 说明
- 本文件名: `Gerrit 手册.md`
- 操作系统: `Ubuntu 18.04.1 AMD64` + `Xubuntu Desktop`
- 用户目录: `/home/imknown/`
- 最后修改: `2018-11-21-15-49-00`

# 运维: 下载 `Gerrit`
- https://gerrit-review.googlesource.com/Documentation/
- https://gerrit-documentation.storage.googleapis.com/Documentation/2.16/index.html
- https://www.gerritcodereview.com/releases-readme.html
- https://gerrit-releases.storage.googleapis.com/index.html

# 运维: 初始化网站 (亦可 用于升级 `Gerrit`)
- 例子一: DEMO
  - `--dev` 会创建 `auth.type = development_become_any_account`, 仅用于 **运维调试**
  - `--batch` 会使用 `默认配置`
``` sh
java -jar gerrit*.war init --batch --dev -d gerrit_testsite
```

- 例子二: 真实项目: `MyGerritWebsite`
``` sh
java -jar gerrit*.war init -d ~/Desktop/MyGerritWebsite/
```

# 运维: 配置 `Gerrit` 环境 (数据库部分 待完善)
> `gerrit.config` 位于 `MyGerritWebsite/etc/`

``` sh
# 仅使用 SSH 和 Google Repo
# git config -f gerrit.config download.scheme ssh
# git config -f gerrit.config --add download.scheme repo_download

# 使用 HTTP 自己实现授权
git config -f gerrit.config auth.type HTTP
# 防止 无法登出
git config -f gerrit.config auth.logoutUrl 'http://goodbye@review.imknown.net/'

# 反代监听地址, 下面会提到
git config -f gerrit.config httpd.listenUrl 'proxy-http://*:8081/'

# 允许 通过SSH 使用插件
git config -f gerrit.config plugins.allowRemoteAdmin true
```

# 运维: `Nginx` 反向代理 配置
- 安装
``` sh
sudo apt install nginx
```

- 配置
``` sh
sudo mousepad /etc/nginx/nginx.conf
```

``` conf
http {
    # Gerrit
    server {
        listen 80;
        server_name review.imknown.net;

        location ^~ / {
            auth_basic "Gerrit Code Review";
            # `auth_basic_user_file` 填写 `Nginx` 的 `账户和密码` 管理文件, 下面会提到
            auth_basic_user_file /home/imknown/Desktop/Gerrit/MyGerritWebsite/etc/account.txt;

            # `proxy_pass` 填写 `Nginx` 的 `监听地址`, 呼应上面 `Gerrit` 的 `httpd.listenUrl`
            proxy_pass        http://127.0.0.1:8081;
            proxy_set_header  X-Forwarded-For $remote_addr;
            proxy_set_header  Host $host;
        }
    }
}
```

- 重启 `Nginx` 生效
``` sh
sudo service nginx reload
# 或者
sudo nginx -s reload
```

# 运维: 插件
> https://gerrit-review.googlesource.com/Documentation/cmd-plugin-install.html  
> https://gerrit-review.googlesource.com/Documentation/config-plugins.html  
> https://www.gerritcodereview.com/config-plugins.html  
> https://gerrit-ci.gerritforge.com/

下载对应版本, 直接扔到 `MyGerritWebsite/plugins` 后, 重启 `Gerrit` 即可

# 运维: 启动/停止/重启 Gerrit
> `gerrit.sh` 位于 `MyGerritWebsite/bin/`

``` sh
sudo ./gerrit.sh start

sudo sh gerrit.sh stop

sudo sh gerrit.sh restart
```

# 运维: 用户账户
`admin@review.imknown.net` 可替换为 `review.imknown.net -l admin`

## 1. 创建
> https://gerrit-review.googlesource.com/Documentation/cmd-create-account.html

``` sh
ssh -p 29418 admin@review.imknown.net \
    gerrit create-account \
        --group "'Android Developers'" \
        --full-name '管理员' \
        --email admin@imknown.net \
        --http-password 123456 \
    admin
```

## 2. 分配密码
- 安装 `apache2-utils`
``` sh
sudo apt install apache2-utils
```

- 创建 反代账户和密码  
`account.txt` 位于 `MyGerritWebsite/etc/`

  - 方法一: 自动创建文件 + 用户名 + 手动输入密码
    ``` sh
    htpasswd -c account.txt admin
    ```

  - 方法二: 手动创建文件 + 用户名 + 预设密码
    ``` sh
    touch account.txt
    htpasswd -b account.txt admin admin
    ```

## 3. 修改 (可选)
> https://gerrit-review.googlesource.com/Documentation/cmd-set-account.html

``` sh
ssh -p 29418 admin@review.imknown.net \
    gerrit set-account \
        --full-name '管理员' \
        --add-email admin@imknown.net \
        --preferred-email admin@imknown.net \
        --http-password 123456
        --active
    admin
```

# 用户: 访问 `Gerrit`
> http://review.imknown.net/

使用 `admin` 登录, **第一个** 注册并登录的, 会被 `Gerrit` **自动** 赋予 `管理员权限`.

# 用户: 修改头像
https://gravatar.com/

# 用户: 修改 `SSH 证书`
> https://gitlab.com/help/ssh/README  
> https://help.github.com/articles/connecting-to-github-with-ssh/

- 查看
> `Windows` 请使用 `cmd type` 或者 `bash`
``` sh
cat ~/.ssh/id_rsa.pub
```

- 新建
> 不指定位置的话, 默认在 ~/.ssh/

``` sh 
ssh-keygen -t rsa -C "admin@imknown.net" -b 4096
```

# 用户: 验证
``` sh
ssh -p 29418 admin@review.imknown.net
ssh -p 29418 notExist@review.imknown.net

# 或者 
ssh -p 29418 review.imknown.net -l admin
ssh -p 29418 review.imknown.net -l notExist
```

# 用户: gsql
- 方法一: 必须启动服务
``` sh
ssh -p 29418 admin@review.imknown.net \
    gerrit gsql
```

- 方法二: 必须关闭服务
``` sh
java -jar gerrit*.war gsql -d MyGerritWebsite
```

# 项目所有者: Project 创建
`Repositories` 右上角 `CREATE NEW`

# 项目所有者: Project 迁移
> https://stackoverflow.com/questions/14789666/import-repository-from-git-to-gerrit

**务必使用 有 `管理员权限` 的账户, 推荐使用 `admin`!  
所以请先在 `Gerrit` 配置 `管理员们` 的 相关 `SSH` 信息**

``` sh
# 获取 原 Gitlab 项目所有分支记录 以及 标签等
git clone --mirror ssh://git@10.20.0.19:1022/android/AndroidBase.git

# 进入目录
cd AndroidBase

# 添加 Gerrit 远端地址
git remote set-url origin ssh://admin@review.imknown.net:29418/AndroidBase

# 使用 管理员权限, 强行推送, 绕过 Gerrit Review
git push -f origin # 
```

想 推送 所有 Tag, 可以参考这个,  
但是 存在 `forge committer(s)` 的时候, 会被拒绝
``` sh 
# git push -f --tags origin
```

# 项目所有者: Project 配置
> https://gerrit-review.googlesource.com/Documentation/config-project-config.html#file-project_config

## 1. 检出
``` sh
git clone ssh://admin@review.imknown.net:29418/All-Projects && scp -p -P 29418 admin@review.imknown.net:hooks/commit-msg All-Projects/.git/hooks/
cd All-Projects
git fetch origin refs/meta/config:refs/remotes/origin/meta/config
git checkout meta/config
```

## 2. 提权
`project.config` 位于 `All-Projects` 的 `refs/meta/config` 分支
``` sh
# 允许管理员 通过SSH 操纵 gsql
git config -f project.config --add capability.accessDatabase 'group Administrators'

# 提交信息
git commit -am "Add access"

# 直接推送, 不需要 Gerrit Review
git push origin meta/config:meta/config
# 需要 Gerrit Review
git push origin meta/config:refs/for/refs/meta/config
```

请在 网页端 http://review.imknown.net/admin/projects/All-Projects,access 的 `refs/heads/*`  
`Add Permission ...` 中 `Add Group` 若干次, 如:
- `Administrators`
- `Project Owners`
- `Registered Users`

具体规则, 请 **复议定制**.

## 3. 刷新
``` sh
ssh -p 29418 admin@review.imknown.net \
    gerrit flush-caches --all

# ssh -p 29418 admin@review.imknown.net \
#     gerrit flush-caches \
#         --cache project_list

# ssh -p 29418 admin@review.imknown.net \
#     gerrit flush-caches \
#         --cache projects
```

# 项目所有者: Project 删除
> https://gerrit.googlesource.com/plugins/delete-project/+/master/src/main/resources/Documentation/config.md

``` sh
ssh -p 29418 admin@review.imknown.net \
    deleteproject delete \
      --force
      --yes-really-delete <project>
```

或者 在 `网页端` 的 `Commands` 点击 `Delete Project`

# 项目所有者: Project 分支管理
`Branches` 右上角 `CREATE NEW`

# 程序员: 推送代码
`Gerrit` 是以 `Change-Id` 为 **最小单位** 进行 `代码评审` 的.

## 1. Git 命令行
> https://www.gerritcodereview.com/concept-refs-for-namespace.html  
> https://stackoverflow.com/questions/7423893/git-alias-for-headrefs-for-master  
> https://stackoverflow.com/questions/9917645/push-to-gerrit-using-sourcetree

- 每次 单独操作
``` sh
# 提交信息
git commit -am '提交的信息'

# 务必推送到 HEAD:refs/for/develop 或者 HEAD:refs/for/refs/heads/develop
git push origin HEAD:refs/for/develop
```

- 或者 替换一下, 一劳永逸 (**不太推荐使用, 尤其混合了 `GUI 工具`, 慎用!!**)
``` sh
# 删除所有 fetch 地址
git config --unset-all remote.origin.fetch
# 添加 fetch 分支
git config remote.origin.fetch +refs/heads/*:refs/remotes/origin/*

# 添加 push 分支
git config remote.origin.push refs/heads/*:refs/for/*
```

## 2. `IDEA系` 的 `gerrit` 插件 推送代码
下载并安装插件.  
`push` 的时候, 注意 勾选最下面 的 `gerrit` 即可.

# 评审人员: 评审
左侧各个标签的作用: 
- `Reviewers`: 被添加的 `评审人员`, 会收到 `待评审` 邮件
- `Topic`: 对 `相近类型` 的 `Change-Id` 进行分组
- `Code-Review (-2 ~ +2)`: 表示 `代码质量` 高低, 存在 `-2` 则 必须改正
- `Verified (-1 ~ +1)`: 表示 `编译器` 能否通过, 存在 `-1` 则 必须改正

点击 上方 `Reply` 可以进行 `代码评审` 操作.  
评审完毕, `管理员(们)` 点击右上角 `submit` 入(Git)库.

# 完整 配置文件 参考
- gerrit.config
``` conf
[gerrit]
	basePath = git
	serverId = 0f6aa719-239f-4a0d-9462-a11952a80f55
	canonicalWebUrl = http://review.imknown.net/
	enableGwtUi = false
	enablePolyGerrit = true
[database]
	type = h2
	database = db/ReviewDB
[noteDb "changes"]
	disableReviewDb = true
	primaryStorage = note db
	read = true
	sequence = true
	write = true
[index]
	type = LUCENE
[auth]
	type = http
	logoutUrl = http://goodbye@review.imknown.net/
[receive]
	enableSignedPush = false
[sendemail]
	smtpServer = smtp.imknown.net
	smtpUser = gerrit@imknown.net
	from = Gerrit<gerrit@imknown.net>
	connectTimeout = 15000
	smtpEncryption = tls
	smtpServerPort = 587
	sslVerify = false
	includeDiff = true
[container]
	user = imknown
	javaHome = /usr/lib/jvm/java-8-openjdk-amd64/jre
[sshd]
	listenAddress = *:29418
[httpd]
	listenUrl = proxy-http://*:8081/
[cache]
	directory = cache
[plugins]
	allowRemoteAdmin = true
```

- secure.config
``` conf
[auth]
	registerEmailPrivateKey = 此处为自动生成的私钥, 请无视
[sendemail]
	smtpPass = <此处填写邮箱密码>
```
