" Execute an ex command in a Scratch buffer
function! scratch#buffer (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   let filter = 1
   if a:0 > 0 && match (a:000[a:0 - 1], '?', -1) != -1
      execute 'silent '.a:command.' '.join(a:000)
      let filter = 0
   else
      execute 'silent '.a:command
   endif
   redir END
   let &more = saveMore
   new | match | setlocal buftype=nofile bufhidden=hide noswapfile
   silent put=lines
   " Example: Scratch ve autocmd - filter 'autocmd' matching lines only
   if a:0 > 0 && filter == 1
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
