augroup FT_COMMENTS_GRP

" autocmd FileType c
" " imap <silent> <buffer> <leader>p printf("\n");<left><left><left><left><left>

autocmd FileType c,cpp
   \ imap <silent> <buffer> <leader>cs /*<cr><cr>/<left><up><space>

autocmd FileType c,cpp,java
   \ imap <silent> <buffer> <leader><leader> /*  */<left><left><left>|

autocmd FileType cpp
   \ imap <silent> <buffer> <leader>p cout << '' << endl;<left><left><left><left><left><left><left><left><left><left>

autocmd FileType java
   \ imap <silent> <buffer> <leader>cs /**<cr><cr>/<left><up><space>

augroup END
