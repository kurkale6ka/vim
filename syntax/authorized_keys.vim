" Highlight emails in ~/.ssh/authorized_keys

setlocal synmaxcol&

syntax match authorizedKeysRsa /^\S\+/
syntax match authorizedKeysEmail /\S\+\s*$/

highlight link authorizedKeysRsa Type
highlight link authorizedKeysEmail Comment
