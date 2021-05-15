if exists('g:bad_practices_loaded') || &cp
  finish
end
let g:bad_practices_loaded = 1

fun! Setup()
    if has('nvim-0.5')
        lua require('bad_practices.nvim/util').turn_on()
    else
        echohl WarningMsg
        echom "vim-bad-practices won't work outside neovim 0.5 or higher"
        echohl None
    endif
endfun

if !has('g:bad_practices_enabled') || g:bad_practices_enabled == 1
    call Setup()
end

command! -nargs=0 BadPracticesEnable lua require('bad_practices.nvim/util').turn_on()
command! -nargs=0 BadPracticesDisable lua require('bad_practices.nvim/util').turn_off()
