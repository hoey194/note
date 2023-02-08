#!/bin/zsh

# 在sage目录下创建文章

title=$1

if [ "${title}" = "吉事语" ]; then
  title=$title`date +%y%m%d`
fi

hexo new post "\"${title}\""
mv /Users/hoey/workspace/hexo/blog-src/note/source/_posts/${title}.md /Users/hoey/workspace/hexo/blog-src/note/source/sage/${title}.md

open /Users/hoey/workspace/hexo/blog-src/note/source/sage/${title}.md

