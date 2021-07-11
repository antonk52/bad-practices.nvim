if exists('g:bad_practices_loaded') || &cp
  finish
end
let g:bad_practices_loaded = 1

let s:n = 'g:bad_practices_'
if exists(s:n.'enabled') || exists(s:n.'most_splits') || exists(s:n.'most_tabs') || exists(s:n.'max_hjkl')
    echohl WarningMsg
    echom "bad_practices.nvim: global variables are no longer supported see :h bad_practices"
    echohl None
endif
