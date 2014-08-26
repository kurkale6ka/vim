augroup FILETYPE_DETECT

   autocmd!

   autocmd BufNewFile,BufRead *.info              set filetype=dosini
   autocmd BufNewFile,BufRead *.json              set filetype=javascript
   autocmd BufNewFile,BufRead /etc/httpd/*/*.conf set filetype=apache
   autocmd BufNewFile,BufRead *.ssi,*.sssi        set filetype=html
   autocmd BufNewFile,BufRead *.ftl               set filetype=xml
   autocmd BufNewFile,BufRead *.pgn,*.chess       set filetype=pgn
   autocmd BufNewFile,BufRead syslog*.conf        set filetype=syslog
   autocmd BufNewFile,BufRead Gemfile,Gemfile.*   set filetype=ruby
   autocmd BufNewFile,BufRead vipw.*              set filetype=passwd

   autocmd BufNewFile,BufRead *.txt,*.text,README,INSTALL,NEWS,TODO
      \ set filetype=txt

augroup END
