# 下载
- https://gerrit-review.googlesource.com/Documentation/
- https://gerrit-documentation.storage.googleapis.com/Documentation/2.16/index.html
- https://www.gerritcodereview.com/releases-readme.html
- https://gerrit-releases.storage.googleapis.com/index.html

# 初始化网站 (亦可 用于升级 `Gerrit`)
- DEMO
  - `--dev` 会创建 `auth.type = development_become_any_account`, 不受权限控制
  - `--batch` 会使用 `默认配置`
``` sh
java -jar gerrit*.war init --batch --dev -d gerrit_testsite
```

- 真实项目: `MyGerritWebsite`
``` sh
java -jar gerrit*.war init -d /home/imknown/Desktop/Gerrit/MyGerritWebsite/
```

# 配置环境 (数据库部分 待完善)
``` sh
# gerrit.config 位于 /home/imknown/Desktop/Gerrit/MyGerritWebsite/etc/

# git config -f gerrit.config download.scheme ssh
# git config -f gerrit.config --add download.scheme repo_download

git config -f gerrit.config auth.type HTTP
git config -f gerrit.config auth.logoutUrl 'http://goodbye@review.imknown.net/'
git config -f gerrit.config httpd.listenUrl 'proxy-http://*:8081/'

git config -f gerrit.config plugins.allowRemoteAdmin true
```

# 反向代理
``` sh
sudo apt install nginx
```

``` sh
sudo mousepad /etc/nginx/nginx.conf
```

``` js
http {
    # Gerrit
    server {
        listen 80;
        server_name review.imknown.net;

        location ^~ / {
            auth_basic "Gerrit Code Review";
            auth_basic_user_file /home/imknown/Desktop/Gerrit/MyGerritWebsite/etc/account.txt;
            proxy_pass        http://127.0.0.1:8081;
            proxy_set_header  X-Forwarded-For $remote_addr;
            proxy_set_header  Host $host;
        }
    }
}
```

``` sh
sudo service nginx reload
# 或者
sudo nginx -s reload
```

# 启动
``` sh
# /gerrit.sh 位于 /home/imknown/Desktop/Gerrit/MyGerritWebsite/bin/
sudo ./gerrit.sh restart
sudo sh gerrit.sh start
sudo /home/imknown/Desktop/Gerrit/MyGerritWebsite/bin/gerrit.sh stop
```

# 插件
> https://gerrit-review.googlesource.com/Documentation/cmd-plugin-install.html  
> https://gerrit-review.googlesource.com/Documentation/config-plugins.html  
> https://www.gerritcodereview.com/config-plugins.html  
> https://gerrit-ci.gerritforge.com/

# 访问
> http://review.imknown.net/

使用 admin 登录 (第一个注册/登录的), **自动** 赋予管理员权限.

# 账户
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
``` sh
sudo apt install apache2-utils
```

``` sh
# account.txt 位于 /home/imknown/Desktop/Gerrit/MyGerritWebsite/etc/

# 方法一: 自动创建文件 + 用户名 + 手动输入密码
htpasswd -c account.txt admin

# 方法二: 手动创建文件 + 用户名 + 预设密码
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

# 验证
``` sh
ssh -p 29418 admin@review.imknown.net
ssh -p 29418 jinhe@review.imknown.net
ssh -p 29418 notExist@review.imknown.net

# 或者
ssh -p 29418 review.imknown.net -l admin
ssh -p 29418 review.imknown.net -l jinhe
ssh -p 29418 review.imknown.net -l notExist
```

# Project 迁移
> https://stackoverflow.com/questions/14789666/import-repository-from-git-to-gerrit

``` sh
git clone --mirror ssh://git@10.20.0.19:1022/android/AndroidBase.git
cd AndroidBase
git remote set-url origin ssh://jinhe@review.imknown.net:29418/AndroidBase
git push -f origin
# git push -f --tags origin # 存在 forge committer 的时候 会被拒绝
```

# Project 配置
> https://gerrit-review.googlesource.com/Documentation/config-project-config.html#file-project_config

## 检出
``` sh
git clone ssh://admin@review.imknown.net:29418/All-Projects && scp -p -P 29418 admin@review.imknown.net:hooks/commit-msg All-Projects/.git/hooks/
cd All-Projects
git fetch origin refs/meta/config:refs/remotes/origin/meta/config
git checkout meta/config
```

## 提权
``` sh
# project.config 位于 All-Projects 的 refs/meta/config 分支
git config -f project.config --add capability.accessDatabase 'group Administrators'

git commit -a -m "Add access"

# directly
git push origin meta/config:meta/config
# or via review
git push origin meta/config:refs/for/refs/meta/config
```

> 请在 网页端 http://review.imknown.net/admin/projects/All-Projects,access 的 `refs/heads/*`  
> `Add Permission ...` 中 `Add Group` 若干次, 如:
> - Administrators
> - Project Owners
> - Registered Users

## 刷新
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

# Project 删除
> https://gerrit.googlesource.com/plugins/delete-project/+/master/src/main/resources/Documentation/config.md

``` sh
ssh -p 29418 admin@review.imknown.net \
    deleteproject delete \
      --force
      --yes-really-delete <project>
```

或者 在 `Old UI` 最下面 点击 <kbk>Delete Project</kbk>

# gsql
- 方法一: 必须启动服务 (参看 `Project 配置`)
``` sh
ssh -p 29418 admin@review.imknown.net \
    gerrit gsql
```

- 方法二: 必须关闭服务
``` sh
java -jar gerrit*.war gsql -d MyGerritWebsite
```

# 用户 修改头像
https://gravatar.com/

# 用户 修改 SSH 证书
> https://gitlab.com/help/ssh/README  
> https://help.github.com/articles/connecting-to-github-with-ssh/

- 查看
``` sh
cat ~/.ssh/id_rsa.pub
```

- 新建
``` sh
# 不指定位置的话, 默认在 ~/.ssh/
ssh-keygen -t rsa -C "jinhe@imknown.net" -b 4096
```

# 用户 Git 操作 (安装 `gerrit 插件`)
``` sh
git commit -m '提交的信息'
git push origin HEAD:refs/for/develop

# 或者 替换一下
git config remote.origin.push refs/heads/*:refs/for/*
```

# 完整 配置文件 参考
- gerrit.config 
``` conf
[gerrit]
	basePath = git
	serverId = 0f6aa719-239f-4a0d-9462-a11952a80f55
	canonicalWebUrl = http://review.imknown.net/
[database]
	type = h2
	database = /home/imknown/Desktop/Gerrit/MyGerritWebsite/db/ReviewDB
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
	smtpPass = 此处填写密码
	from = Gerrit<gerrit@imknown.net>
	connectTimeout = 60000
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
