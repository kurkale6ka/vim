augroup filetypedetect

    autocmd BufNewFile,BufRead *.info              set filetype=dosini
    autocmd BufNewFile,BufRead *.json              set filetype=javascript
    autocmd BufNewFile,BufRead /etc/httpd/*/*.conf set filetype=apache
    autocmd BufNewFile,BufRead *.ssi,*.sssi        set filetype=html
    autocmd BufNewFile,BufRead *.ftl               set filetype=xml
    autocmd BufNewFile,BufRead *.pgn,*.chess       set filetype=pgn
    autocmd BufNewFile,BufRead *sudoers            set filetype=sudoers

    autocmd BufNewFile,BufRead *.txt,*.text,README,INSTALL,NEWS,TODO
       \ set filetype=txt

augroup END
