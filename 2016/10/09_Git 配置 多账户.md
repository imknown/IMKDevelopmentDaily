因为 之前 电脑 先使用了 `github`,  
导致 `git global config` 信息 都是 `github + gravatar` 相关的.  
公司邮箱 注册了 公司搭建的 `gitlab`, 发现 `push` 的时候,  
并不是 `公司邮箱` (虽然用 `公司邮箱账户` 登录的).

暂时 找了一个 简单解决方案,  
就是 给 `公司邮箱` 分配独立的 `git config`.  

先 `cd` 到 指定的 `git repo` 目录下:  
``` bash
git config user.name <公司用户名, 应该只支持数字英文下划线>
git config user.email <公司邮箱>
```

当然, 如果有必要的话, 可以考虑使用 `SSH` 登录.

# 参考
- http://www.imooc.com/article/7419
- http://www.liaohuqiu.net/cn/posts/git-setup-and-setting/
- https://gist.github.com/suziewong/4378434

---
以下是题外话

---

# Git SSH 登录相关
- http://blog.csdn.net/accountwcx/article/details/46822257
- https://segmentfault.com/a/1190000002645623
- http://www.oschina.net/question/230623_248173?fromerr=QzmFotvK#answer_1003865

# Linux 远程登录
- SecureCRT
- PuTTY
- RDesktop (跨平台远程桌面, 姑且算上吧)
- TeamViewer (跨平台远程桌面, 姑且算上吧)

# 关键字
- 非对称加密算法: 
 * RSA
 * GnuPG
- PuTTYGen, ssh-keygen
 
