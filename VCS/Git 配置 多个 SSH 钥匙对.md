- 查看现有 `私钥`
``` bash
ssh-add -l # 默认是 SHA256
ssh-add -l -E md5
ssh-add -l -E SHA1
```

- 添加其他的 `私钥`
``` bash
eval $(ssh-agent -s)
# ssh-add ~/.ssh/id_rsa # 这个是默认位置的, 可不写
ssh-add /d/1_imknown/Keys/SSH2/imknown_rsa # 改成自己的路径...
```

- SSH 添加多个管理 (编辑 `~/.ssh/config` 文件, 添上 下面两行)
``` config
IdentityFile "~/.ssh/id_rsa"
IdentityFile "/d/1_imknown/Keys/SSH2/imknown_rsa" # 改成自己的路径...
```

- 验证
``` bash
ssh -T git@github.com
ssh -vT git@github.com # 普通排错
ssh -vvv git@github.com # 终极排错
```

- 参考
  - https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
  - https://help.github.com/articles/troubleshooting-ssh/
  - https://help.github.com/articles/error-permission-denied-publickey/
  - https://stackoverflow.com/questions/2419566/best-way-to-use-multiple-ssh-private-keys-on-one-client
  - https://stackoverflow.com/questions/13509293/git-fatal-could-not-read-from-remote-repository/43476821
  - https://gist.github.com/jexchan/2351996
