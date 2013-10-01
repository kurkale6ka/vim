" Add/Subtract
function! number#change(operation, direction)

   if &nrformats =~ 'alpha'
      let pattern = '[[:alpha:][:digit:]]'
   else
      let pattern = '[[:digit:]]'
   endif

   if 'b' == a:direction
      call search(pattern, 'bcw')
   else
      call search(pattern, 'cw')
   endif

   if 'a' == a:operation
      execute 'normal! '.v:count1."\<c-a>"
      silent! call
         \ repeat#set(":\<c-u>call AddSubtract('a', '".a:direction."')\<cr>")
   else
      execute 'normal! '.v:count1."\<c-x>"
      silent! call
         \ repeat#set(":\<c-u>call AddSubtract('s', '".a:direction."')\<cr>")
   endif

endfunction
