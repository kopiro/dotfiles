#!/bin/bash
set -x

ln -sf $(pwd)/conf/bash_profile.sh ~/.bash_profile
ln -sf $(pwd)/conf/eslintrc.json ~/.eslintrc.json
ln -sf $(pwd)/conf/gitignore_global.txt ~/.gitignore_global

chmod +x $(pwd)/bin/*
