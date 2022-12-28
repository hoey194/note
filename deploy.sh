#!/bin/zsh



cd /Users/hoey/workspace/hexo/blog-src/note
hexo clean
hexo generate
echo "note.hoey.tk" > /Users/hoey/workspace/hexo/blog-src/note/public/CNAME

git config --global user.name "hoey194"
git config --global user.email "377954575@qq.com"
hexo deploy

git config --global --unset user.name
git config --global --unset user.email
