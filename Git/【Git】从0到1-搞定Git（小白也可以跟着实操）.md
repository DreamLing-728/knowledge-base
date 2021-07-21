作为程序员，Git是必会的东西，不会Git挺难受的，但其实只要花上几个小时就能学会，也就那么回事。我整理了Git的重点内容，更多以问题场景加操作的形式展现，小白也能学得会。（ps：别想着一小时速成，如果你是小白，多花两三个小时整体理解一下原理，这样才能完全掌握）
## 一. 什么是Git
我们经常听到Git，Github，先区分一下Git和GitHub的区别。总结来说，Git是本地的仓库，Github是远端的仓库，Git还提供了一些操作让我们把代码从本地仓库和远端仓库之间进行传送。除了Github、还有Gitlab和Gitee等，都是进行代码版本管理的远程仓库。

废话不多说，先**安装Git**。

官网地址：https://git-scm.com/downloads (不能翻墙的同学，可以用下面的国内镜像地址)

国内镜像地址：https://www.jianshu.com/p/f3470d62a0c7

安装过程就不讲了，一直点next就好，安装好后，在cmd输入：**git --version**，如果可以看到版本号，说明安装成功。

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/665ec9a6e7fa452ba039977c0465a396~tplv-k3u1fbpfcp-zoom-1.image)

## 二. 配置Git
- git config --global user.name "chengmengling"	配置用户名
- git config --global user.email "1796256205@qq.com"	配置邮箱
- git config --get user.name	查看用户名
- git config --get user.email	查看邮箱

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9a6d741e85b24e09a457cdf3fc2070ca~tplv-k3u1fbpfcp-zoom-1.image)

## 三. 关于配置的知识
Git有三种配置，从小到大分别为：local，global，system。上面第二步我们是在global里配置用户名和邮箱，配置的详细介绍如下：
### 1. 三种配置
三种配置所在的文件夹
- system:<git安装路径>\mingw64\etc\gitconfig
- global:<用户根目录>\.gitconfig
- local:<当前文件夹>\.git\config
### 2. 查看所有的配置
- git config --system --list
- git config --global --list
- git config --local --list
### 3. 查看某个配置
git config --get user.name
### 4. 增加一个配置
git config --global --add user.namaa "cml"
增加后的配置长这样
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/57403f990d2741dca7936df1eb0b8af2~tplv-k3u1fbpfcp-zoom-1.image)
### 5. 删除一个配置
git config --global --unset user.namaa
## 四. 本地仓库管理
### 1.原理
不要着急操作，原理还是要懂一点的，理解原理可以帮助我们更好掌握Git的整体操作流程，主要先熟悉一下Git的四种状态和三个区就好：

四种状态：未跟踪态，已修改态，暂存态，已修改态

先大概把这个图过大概一遍，后续我们会结合场景操作对应起来
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7a237fb17fb04a3d8317e8f7c1a8cbd6~tplv-k3u1fbpfcp-zoom-1.image)
三个区：工作区，state区，master区
1. 工作区：我们平时修改代码的文件一般都在工作区
2. 版本区：
- 2.1 包括state缓存区，git add 操作的代码在state区
- 2.2 还包括master区版本区，git commit 操作后的代码在master
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/737fb7e2529640b1be90803f4768fb87~tplv-k3u1fbpfcp-zoom-1.image)
### 2. 场景+操作
前方高能，最重要的内容来了，这部分内容跟着一个个操作下来后，对于Git的理解，你会有一种恍然大悟的感觉。

#### **场景1**：添加一个新的文件，并且提交到本地仓库
- 1. 新建一个文件 		（未跟踪态，在工作区）
- 2. git add <文件名>	（未跟踪态-->暂存态，进入state区）
- 3. git commit -m "<描述>"（暂存态-->未修改态，进入master区）

#### **场景2**：修改一个已有的文件，且提交到本地仓库
- 1. 修改一个文件		（未跟踪态，在工作区）
- 2. git add <文件名>	（未修改态-->暂存态，进入state区）
- 3. git commit -m "<描述>"	（暂存态-->未修改态，进入master区）
 
 把场景操作和前面的原理的四个状态+三个区对应起来，是不是好理解了一点，后续的操作你们也可以对应上，我就不一 一加上了。
 
#### **场景3**：删除一个文件，且提交到本地仓库
- 1. git rm <文件名>		
- 2. git commit -m "<描述>"		

#### **场景4**：恢复一个已经commit的文件删除操作
- 1. 从 git log 里找到删除操作的上一个commit id
- 2. git checkout ```<commit id>``` 文件名

#### **场景5**：恢复一个已经commit的文件修改操作，想回到未修改操作
-   1. 从git log 里找到修改操作的上一个commit id
-  2. git checkout ```<commit id>``` 文件名

  
#### **场景6**：一个文件被add了，希望回到没有被add的状态
- 1. 方法一：git reset <文件名>
- 2. 方法二：git rm --cache <文件名>  {运行这个语句会真的删除stage中的文件，一般用第一种}
  
#### **场景7**：修改了一个文件，想恢复原来的状态（回到最后一次commit后的文件状态）
- 1. git checkout <文件名>
  
#### **场景8**：删除所有untracked文件（文件被新建了，但是没有被编辑)
- 1. 方法1：git clean -f .  (注意最后有一个点)
- 2. 方法2：git clean -df

## 五.远程版本的管理
### 1. 概念
- 远程主机：remote
- 从远程仓库建立本地仓库：git clone
- 直接建立本地仓库：git init

### 2. 场景+操作
#### 场景1：查看是从哪里克隆来的
- git remote  查看主机的名字
- git remote -v 查看主机的地址
- git remote add/remove/rename
  
#### 场景2：本地有了改动，需要同步到远端
```工作中提交代码的顺序(以dev分支为例)```
- 1. git add --all
- 2. git pull origin dev
- 3. git commit -m "feat:完成了一个功能"
- 4. git push origin dev
注意，2和3的顺序，是先pull再commit，避免不必要的合并

## 六. 多版本管理
### 1. 概念
- 概念：工作中需要不同的代码备份，以应对不同的需求，比如线上紧急bugfix与功能开发的矛盾，那么在git中，采用分支来进行管理
- 分支定义：如果认为commit是提交文件的一个快照，那每个commit是链表中的一个节点，分支就是链表头（指针）

### 2. 场景+操作
#### 场景1：查看现有分支
- 查看所有本地分支： git branch
- 查看所有远程分支：git branch -r
- 查看所有本地分支和远程分支：git branch -a

#### 场景2：创建一个新的分支，但是没有切到新分支里
- git branch <新分支名>
#### 场景3：创建新分支，同时切换到新分支里
- 1. git branch <新分支名>
- 2. git checkout -b <新分支名>
#### 场景4：在本地仓库创建远程仓库的另一个分支```(常用)```
-   git checkout -b <本地分支名> origin/<远程分支名>
#### 场景5：在dev分支完成后，需要将dev分支开发的代码merger到master分支里
-   1. git checkout master： 先切换到master分支
-   2. git merge dev： merge dev到master分支（有可能出现冲突，需要解决冲突）
#### 场景6：删除一个分支
-   git branch -d <分支名>
#### 场景7：切换到上一个分支
-   git checkout -


## 七. 面试题

### 1. git 几个commit点合并成一个commit点

参考文章：[git 几个commit点合并成一个commit点](https://blog.csdn.net/u013276277/article/details/82470177)

因为实际项目过程中，一个功能的开发我们可能有多次commit提交，为了使项目的分支更整洁，一个功能最好只有一个commit，所以我们就会有把多个commit合并成一个commit的需求。整个合并过程如下：

- 第一步：查看我们所有的commit记录：git log
- 第二步：确定从哪个commit往后需要合并操作：git rebase -i commitId
- 第三步：进入编辑合并的分支的页面：squash 代表这一个commit会合并到前一个commit，编辑好后保存退出（按esc + ： + wq + 回车）
- 第四步：进入信息确认页面保存退出，完成
