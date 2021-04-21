#!/bin/bash
# 查询当前目录下的磁盘使用情况(需要保证有权限) 
sort=$1
if [ -z "$sort" ]
then
	du -d 1 -h .
else
	du -d 1 -h . | sort --human-numeric-sort
fi