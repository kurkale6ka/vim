" Highlight emails in ~/.ssh/authorized_keys

setlocal synmaxcol&

syntax match authorizedKeysType /^\S\+/
syntax match authorizedKeysComment /\S\+\s*$/

highlight link authorizedKeysType Type
highlight link authorizedKeysComment Comment

" vim: filetype=vim
