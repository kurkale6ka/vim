augroup filetypedetect

    autocmd BufRead,BufNewFile *.sandbox set filetype=apache
    autocmd BufRead,BufNewFile *.access  set filetype=apache
    autocmd BufRead,BufNewFile *.conf    set filetype=apache
    autocmd BufRead,BufNewFile *.info    set filetype=dosini
    autocmd BufRead,BufNewFile *.phtml   set filetype=html
    autocmd BufRead,BufNewFile *.ssi     set filetype=html
    autocmd BufRead,BufNewFile *.sssi    set filetype=html

augroup END
