#!/bin/bash
# 生成对应包的 version.go 文件，创建一个基础发版的文件
# 使用方式 gen_go_version.sh $package_name
package_name=$1

cat <<EOT > ./version.go
package $package_name
import (
	"fmt"
	"log"
)
const Version = "v0.0.0"
func init() {
	log.Println(fmt.Sprintf("[$package_name] version=%s", Version))
}
EOT
