---
title: Hexo隐藏文章
abbrlink: 1c5dc392
date: 2022-12-12 09:52:16
---

### 安装

在站点根目录下执行

```shell
cnpm install hexo-hide-posts --save
```

### 配置

在站点目录下的`_config.yml`中如下配置：

```shell
# hexo-hide-posts
hide_posts:
  # 可以改成其他你喜欢的名字
  filter: hidden
  # 指定你想要传递隐藏文章的位置，比如让所有隐藏文章在存档页面可见
  # 常见的位置有：index, tag, category, archive, sitemap, feed, etc.
  # 留空则默认全部隐藏
  public_generators: []
  # 为隐藏的文章添加 noindex meta 标签，阻止搜索引擎收录
  noindex: true

```

### 使用

在文章的属性中定义 `hidden: true` 即可隐藏文章。

```
---
title: hidden test
date: 2022-12-12 09:49:19
hidden: true
---
```

虽然首页上被隐藏了，但你仍然可以通过 `https://hexo.test/lorem-ipsum/` 链接访问它。

你可以在命令行运行 `hexo hidden:list` 来获取当前所有的已隐藏文章列表。



参考blog：https://www.cnblogs.com/yangstar/articles/16690342.html

