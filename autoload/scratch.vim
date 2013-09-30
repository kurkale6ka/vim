" Execute an ex command in a Scratch buffer
function! scratch#buffer (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   execute 'silent '.a:command
   redir END
   let &more = saveMore
   new | setlocal buftype=nofile bufhidden=hide noswapfile
   silent put=lines
   if a:0 > 0
      execute 'silent vglobal/'.a:1.'/delete'
   endif
   if a:command == 'scriptnames'
      silent %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
   endif
   silent %substitute/\%^\_s*\n\|\_s*\%$
   let height = line('$') + 3
   execute 'normal! z'.height."\<cr>"
   0
endfunction
