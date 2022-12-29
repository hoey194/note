---
title: Mac下VIM配置
abbrlink: 7a63f10c
date: 2022-12-08 22:20:30
---



# 安装gruvbox主题

```shell
mkdir -p ~/.vim/colors ; cd ~/.vim/colors
curl -O https://raw.githubusercontent.com/morhetz/gruvbox/blob/master/colors/gruvbox.vim


vim ~/.vimrc
"********************************gruvbox主题******************************"
call plug#begin()
Plug 'morhetz/gruvbox'
call plug#end()
colorscheme gruvbox
set background=dark
```

执行完成以后，重新运行vim查看效果。



# vimrc其他设置

```shell

"********************************基本设置******************************"
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set backspace=2              " 设置退格键可用
set shiftwidth=4     		 " 自动缩进4空格
set smartindent              " 智能自动缩进
set number                   " 在每一行最前面显示行号
set showmatch                " 高亮显示对应的括号
set mouse=a                  " 启用鼠标
set ruler                    " 在编辑过程中，在右下角显示光标位置的状态行
set cursorline               " 突出显示当前行
set noswapfile               " 设置无交换区文件"
set writebackup              " 设置无备份文件
set nobackup                 " 设置无备份文件
set autochdir                " 设定文件浏览器目录为当前目录
set foldmethod=syntax        " 选择代码折叠类型
set laststatus=2             " 开启状态栏信息
set cmdheight=2              " 命令行的高度，默认为1，这里设为2
set autoread                 " 当文件在外部被修改，自动更新该文件
set autoread                 " 自动检测并加载外部对文件的修改
set autowrite                " 自动检测并加载外部对文件的修改
set showcmd                  " 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来
syntax enable                " 打开语法高亮


if has("gui_running")
    set guioptions+=b        " 显示底部滚动条
    set nowrap               " 设置不自动换行
endif

"********************************设置编码*******************************"
" 设置换行编码
set fileformats=unix,dos,mac
" 设置Vim 内部使用的字符编码方式
set encoding=utf-8
" 设置文件编码
if has("win32")
	set fileencoding=chinese
else
	set fileencoding=utf-8
endif
" 解决consle输出乱码
language messages zh_CN.utf-8
```

