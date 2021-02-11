#!/bin/bash
find _apps -type f -exec sh -c 'sort $1 | uniq -u | tee $1' _ {} \;