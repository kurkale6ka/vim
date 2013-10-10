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

" For shell scripts, use bash syntax not sh
autocmd FileType sh
   \ let g:is_bash = 1

" the letter c is used for surrounding
autocmd FileType ruby
   \ imap <silent> <buffer> <localleader>p puts ''<left>|
   \ let b:surround_99 = "=begin \r =end"

" To be improved
autocmd FileType perl
   \ setlocal makeprg=perl\ -c\ %\ $*|
   \ setlocal errorformat=%m\ at\ %f\ line\ %l.

augroup END
