错误信息 如下:
> Failed with error: fatal: The remote end hung up unexpectedly fatal: The remote end hung up unexpectedly error: RPC failed; result=22, HTTP code = 413

貌似 `最简单的解决方法` 就是用 `SSH` 登录, 或者 使用 `git 协议`...  
其次就是 同时改造 `反代的配置` 和 `Repo 的 Git config`...  

# 参考
- http://stackoverflow.com/questions/7489813/github-push-error-rpc-failed-result-22-http-code-413
- http://stackoverflow.com/questions/15240815/git-fatal-the-remote-end-hung-up-unexpectedly
- http://stackoverflow.com/questions/32859906/error-rpc-failed-result-22-http-code-413-fatal-the-remote-end-hung-up-unex
- https://github.com/gitlabhq/gitlabhq/issues/3099
- https://gitlab.com/gitlab-org/gitlab-ce/issues/1902
- https://confluence.atlassian.com/stashkb/error-rpc-failed-result-22-push-to-stash-fails-604537633.html
- https://confluence.atlassian.com/stashkb/git-push-fails-fatal-the-remote-end-hung-up-unexpectedly-282988530.html
- https://confluence.atlassian.com/stashkb/git-push-fails-client-intended-to-send-too-large-chunked-body-590251250.html
