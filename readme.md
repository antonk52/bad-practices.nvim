# bad-practices.nvim

A plugin to help give up bad practices in neovim.

![bad-practices 1](https://user-images.githubusercontent.com/18750590/122595373-fc79ca80-d085-11eb-82fa-df1e3774dedd.gif)

Alternatively if you have [nvim-notify](https://github.com/rcarriga/nvim-notify) installed you can get pretty notifications about tapping into bad practices.

## Installation

Using vim-plug

```vim
Plug 'antonk52/bad-practices.nvim'
```

## Setup

To enable the plugin you need to call `setup` with the options

```lua
require('bad_practices.nvim').setup({
    most_splits = 3, -- how many splits are considered a good practice(default: 3)
    most_tabs = 3, -- how many tabs are considered a good practice(default: 3)
    max_hjkl = 10, -- how many times you can spam hjkl keys in a row(default: 10)
})
```
