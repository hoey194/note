#!/bin/zsh



cd /Users/hoey/workspace/hexo/blog-src/note
hexo clean
hexo generate
echo "note.hoey.tk" > /Users/hoey/workspace/hexo/blog-src/note/public/CNAME
hexo deploy
