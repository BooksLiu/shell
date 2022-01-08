#!/bin/bash
set -ex
find . -type f -depth 1 -name "$1" -print0 | xargs -0 -n1
