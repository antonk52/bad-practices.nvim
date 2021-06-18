# bad-practices.nvim

A plugin to help give up bad practices in neovim.

![bad-practices 1](https://user-images.githubusercontent.com/18750590/122595373-fc79ca80-d085-11eb-82fa-df1e3774dedd.gif)

## Installation

Using vim-plug

```vim
Plug 'antonk52/bad-practices.nvim'
```

## Options

- `g:bad_practices_most_splits` - how many splits are considered a good practice(default: 3)
    <br>`let g:bad_practices_most_splits=5`
- `g:bad_practices_most_tabs` - how many tabs are considered a good practice(default: 3)
    <br>`let g:bad_practices_most_tabs=5`
- `g:bad_practices_max_hjkl` - how many times you can spam hjkl keys in a row(default: 10)
    <br>`let g:bad_practices_max_hjkl=5`
