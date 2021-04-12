# shell
shell 工具集合

## quick_commit.sh
将当前写的代码 append 到前一个 commit 然后强推到远端分支（仅可以在个人分支下用这个命令）

## gen_go_version.sh
生成对应包的 version.go 文件，创建一个基础发版的文件

使用方式:
* gen_go_version.sh 发版包名

## release_go.sh
快速给 go 项目进行发版
使用说明:
* release_go.sh 发版包名 ps: 默认发 v0.x.0
* release_go.sh 发版包名 patch ps: 发 v0.0.x
* release_go.sh 发版包名 major ps: 发 vx.0.0