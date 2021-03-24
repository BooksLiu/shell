#!/bin/bash

# 前提条件
# 在 go 的包目录下有一个 version.go 的文件 且 文件模板如下
#package $package_name
#
#import (
#	"fmt"
#	"log"
#)
#
#const Version = "v0.0.0"
#
#func init() {
#	log.Println(fmt.Sprintf("[$package_name] version=%s", Version))
#}

# 使用方法
# release_go.sh 发版包名 ps: 默认发 v0.x.0
# release_go.sh 发版包名 hotfix ps: 发 v0.0.x
# release_go.sh 发版包名 main ps: 发 vx.0.0

#set -ex

# get_package package
function get_package() {
  echo $1
}

# get_version_all_str package
function get_version_all_str() {
  all_version=$(cat version.go | tr -d '\r\n' | cut -d '"' -f 6-6)
  echo $all_version
}

# incr_version package
function incr_version() {
  choice=$1
  all_version=$(get_version_all_str)
  mid_version=$(echo $all_version | cut -d '/' -f 2-2 | cut -d 'v' -f 2-2 | cut -d '.' -f 2-2)
  prefix_version=$(echo $all_version | cut -d '/' -f 2-2 | cut -d 'v' -f 2-2 | cut -d '.' -f 1-1)
  suffix_version=$(echo $all_version | cut -d '/' -f 2-2 | cut -d 'v' -f 2-2 | cut -d '.' -f 3-3)
  if [ "$choice" == "main" ];then
    prefix_version=$((prefix_version+1))
  elif [ "$choice" == "hotfix" ];then
    suffix_version=$((suffix_version+1))
  else
    mid_version=$((mid_version+1))
  fi
  new_all_version="v$prefix_version.$mid_version.$suffix_version"
  echo $new_all_version
}

# incr_version_to_file package
function incr_version_to_file() {
  package_name=$1
  choice=$2
  new_version=$(incr_version $choice)
  cat <<EOT > ./version.go
package $package_name

import (
	"fmt"
	"log"
)

const Version = "$new_version"

func init() {
	log.Println(fmt.Sprintf("[$package_name] version=%s", Version))
}
EOT
}

# commit__and_tag_version package ver
function commit__and_tag_version() {
  package=$1
  version=$2

  # git add $package
  # git commit -m "release $version"
  # git tag $version -m "release $version"
}

function auto_incr_tag() {
  package_name=$1
  choice=$2

  # some info
  old_version=$(get_version_all_str)
  new_version=$(incr_version $choice)

  # update file
  incr_version_to_file $package_name $choice

  # commit and tag to git
  commit__and_tag_version $package_name $new_version

  echo "package: $package_name"
  echo "old_version: $old_version"
  echo "new_version: $new_version"
}


auto_incr_tag $1 $2

