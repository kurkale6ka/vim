augroup FT_COMMENTS_GRP

autocmd!

" Comments: \\
autocmd FileType c,cpp,java,javascript
   \ imap <silent> <buffer> <localleader><localleader> /*  */<left><left><left>|

" Comments: \cs
autocmd FileType c,cpp,javascript
   \ imap <silent> <buffer> <localleader>cs /*<cr><cr>/<left><up><space>

" Comments: \cs
autocmd FileType java
   \ imap <silent> <buffer> <localleader>cs /**<cr><cr>/<left><up><space>

" autocmd FileType c
" " imap <silent> <buffer> <localleader>p printf("\n");<left><left><left><left><left>

autocmd FileType cpp
   \ imap <silent> <buffer> <localleader>p cout << '' << endl;<left><left><left><left><left><left><left><left><left><left>

" To be improved
autocmd FileType perl
   \ setlocal makeprg=perl\ -c\ %\ $*|
   \ setlocal errorformat=%m\ at\ %f\ line\ %l.

augroup END
