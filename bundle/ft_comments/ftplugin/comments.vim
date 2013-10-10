augroup FT_COMMENTS_GRP

" Comments: \\
autocmd FileType c,cpp,java,javascript
   \ imap <silent> <buffer> <leader><leader> /*  */<left><left><left>|

" Comments: \cs
autocmd FileType c,cpp,javascript
   \ imap <silent> <buffer> <leader>cs /*<cr><cr>/<left><up><space>

" Comments: \cs
autocmd FileType java
   \ imap <silent> <buffer> <leader>cs /**<cr><cr>/<left><up><space>

" autocmd FileType c
" " imap <silent> <buffer> <leader>p printf("\n");<left><left><left><left><left>

autocmd FileType cpp
   \ imap <silent> <buffer> <leader>p cout << '' << endl;<left><left><left><left><left><left><left><left><left><left>

" To be improved
autocmd FileType perl
   \ set makeprg=perl\ -c\ %\ $*|
   \ set errorformat=%m\ at\ %f\ line\ %l.

augroup END
