此篇文章 为 历史回顾, 原始地址:  
http://blog.csdn.net/imknown/article/details/51227694  

## 参考资料
- http://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository
- https://help.github.com/articles/syncing-a-fork/#platform-windows
- https://www.zhihu.com/question/20171506

## 根据 上面 知乎用户 王徐阳 的答案 整理:
- A 为 原始 Repo, B 为 A 的 Forked Repo

- 先把 B clone 到本地
`git clone B_REPOSITORY_URL`

- 再 cd 到 本地B 的目录
- 把 A 作为一个 remote 加到 本地B 中 (一般命名为upstream)
`git remote add upstream A_REPOSITORY_URL`

- pull 另一个 A 的 remote (upstream) 的相应分支 (比如 master)
`git pull upstream master`

- 最后 push 回 B
`git push origin master`