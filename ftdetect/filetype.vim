augroup FILETYPE_DETECT

   autocmd!

   autocmd BufNewFile,BufRead *.info       set filetype=dosini
   autocmd BufNewFile,BufRead *.json       set filetype=javascript
   autocmd BufNewFile,BufRead *.ftl        set filetype=xml
   autocmd BufNewFile,BufRead *.epp        set filetype=eruby
   autocmd BufNewFile,BufRead syslog*.conf set filetype=syslog
   autocmd BufNewFile,BufRead .tmux.conf   set filetype=tmux
   autocmd BufNewFile,BufRead vipw.*       set filetype=passwd
   autocmd BufNewFile,BufRead iptables     set filetype=iptables
   autocmd BufNewFile,BufRead known_hosts  set filetype=known_hosts
   autocmd BufNewFile,BufRead relayd.conf  set filetype=pf

   autocmd BufNewFile,BufRead */httpd/*/*.conf set filetype=apache

   autocmd BufNewFile,BufRead */[aA]nsible/*.yml set filetype=ansible

   autocmd BufNewFile,BufRead */authorized_keys* set filetype=authorized_keys

   autocmd BufNewFile,BufRead */postfix/aliases set filetype=mailaliases

   autocmd BufNewFile,BufRead
      \ *.pgn
      \,*.chess
      \ set filetype=pgn

   autocmd BufNewFile,BufRead
      \ *.ssi
      \,*.sssi
      \ set filetype=html

   autocmd BufNewFile,BufRead
      \ Gemfile
      \,Gemfile.*
      \ set filetype=ruby

   autocmd BufNewFile,BufRead
      \ */zsh/autoload/*
      \,*/zsh/autoload/*/*
      \,*/zsh/after/*
      \ set filetype=zsh

   autocmd BufNewFile,BufRead
      \ *.txt
      \,*.text
      \,README
      \,INSTALL
      \,NEWS
      \,TODO
      \ set filetype=txt

augroup END
