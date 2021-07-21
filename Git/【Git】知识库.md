### 必备技能：如何把自己的分支合到dev分支上？
工作场景：master分支我们是不能动的，dev是团队所有的开发分支，dev-cml是从dev分支克隆的，是我自己的开发分支，当我在dev-cml分支开发完成后，需要将dev-cml分支合并到dev分支，整个过程如下：
1. 先将dev分支合并到dev-cml分支，先解决冲突，因为dev分支可能会有冲突，已经不是我们当时克隆的dev分支了
2. 再把dev-cml分支合并到dev分支
3. 把dev分支发布到测试服，以便于后端能看到前端的进度

实际操作如下：
1. git branch 查看当前的本地分支
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5529d18a8298465fade5c949b80bff92~tplv-k3u1fbpfcp-watermark.image)

2. 目前本地只有dev-cml分支，所以我们执行以下命令，把dev分支也克隆到本地
git checkout -b dev origin/dev
此时我们查看分支就会有两个，dev和dev-cml
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d998662427d2475799bea620e7a637c3~tplv-k3u1fbpfcp-watermark.image)

3. 把dev分支合并到dev-cml，分两步
切换到dev-cml分支：git checkout dev-cml
合并dev分支：git merge dev

4. 再把dev-cml合并到dev分支，一样分两步
切换到dev分支：git checkout dev
合并dev-cml分支：git merge dev-cml

5. 把dev分支push到远程,以防万一，把下面的命令都敲一遍
git checkout dev
git status
git add --all
git commit -m "message"
git pull origin dev
git push origin dev

6. 最后在本地的dev分支执行以下命令发布到测试服务器
npm run deploy:preprod

## 常用操作
### 1.远程仓库
``` 
查看远程仓库：git remote
删除远程仓库：git remote rm origin
添加远程仓库：git remote add origin https://github.com/DreamLing-728/knowledge-base.git
```
### 2.分支操作
```
切换远程分支：git checkout -b dev origin/dev
```

### 3.回退到上一个commit
```
git reset –hard 8ff24a6803173208f3e606e32dfcf82db9ac84d8
```

### 4.gitlab 每次都要输入账号密码
```
https://blog.csdn.net/guzhao593/article/details/84747613
```

## 常见报错
1. OpenSSL SSL_read: Connection was reset, errno 10054 错误解决
先运行下面这行
```
git config --global http.sslVerify "false"
```
再重新执行git命令即可解决