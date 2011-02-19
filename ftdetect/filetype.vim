augroup filetypedetect

    autocmd BufRead,BufNewFile *.info     set filetype=dosini
    autocmd BufRead,BufNewFile *.json     set filetype=javascript
    autocmd BufRead,BufNewFile *.inc      set filetype=apache
    autocmd BufRead,BufNewFile *.sandbox  set filetype=apache
    autocmd BufRead,BufNewFile *.access   set filetype=apache
    autocmd BufRead,BufNewFile *.conf     set filetype=apache
    autocmd BufRead,BufNewFile *.platform set filetype=apache
    autocmd BufRead,BufNewFile *.ssi      set filetype=html
    autocmd BufRead,BufNewFile *.sssi     set filetype=html
    autocmd BufRead,BufNewFile *.ftl      set filetype=xml
    autocmd BufRead,BufNewFile *.feature  set filetype=ruby
    autocmd BufRead,BufNewFile *.pgn      set filetype=pgn
    autocmd BufRead,BufNewFile *.txt      set filetype=txt

augroup END
