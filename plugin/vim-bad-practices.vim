fun! Setup()
    if has('nvim')
        autocmd! CursorHold * lua require('vim_bad_practices').check_static()
    else
        echohl WarningMsg
        echom "vim-bad-practices won't work outside neovim"
        echohl None
    endif
endfun

autocmd VimEnter * call Setup()
