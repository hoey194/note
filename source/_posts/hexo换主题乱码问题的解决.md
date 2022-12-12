---
title: hexo换主题乱码问题的解决
date: 2022-12-08 12:04:19
---



使用next主题时运行报错

## 问题的表现

```{% extends '_layout.swig' %} {% import '_macro/post.swig' as post_template %}....................```

## 问题原因

原因是hexo在5.0之后把swig给删除了需要自己手动安装

## 问题解决

```css
 npm i hexo-renderer-swig
```

之后重新

```verilog
hexo clean          
hexo generate      
hexo server
```

