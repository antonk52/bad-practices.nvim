# bad-practices.nvim

A plugin to help give up bad practices in neovim.

<video autoplay src="https://user-images.githubusercontent.com/5817809/122409184-9c066280-cf8b-11eb-9b65-bd71d06a311e.mov" style="max-width: 100%">
</video>

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
