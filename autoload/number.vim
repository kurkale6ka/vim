" Add/Subtract
function! number#change(operation, direction)

   if &nrformats =~ 'alpha'
      let pattern = '[[:alpha:][:digit:]]'
   else
      let pattern = '[[:digit:]]'
   endif

   " search forward
   if 'f' == a:direction

      call search(pattern, 'cw')

      if 'a' == a:operation
         silent! call repeat#set("\<c-a>")
      else
         silent! call repeat#set("\<c-x>")
      endif

   " search backward
   else

      call search(pattern, 'bcw')

      if 'a' == a:operation
         silent! call repeat#set("\\\<c-a>")
      else
         silent! call repeat#set("\\\<c-x>")
      endif

   endif

   " add
   if 'a' == a:operation
      execute 'normal! '.v:count1."\<c-a>"
   " subtract
   else
      execute 'normal! '.v:count1."\<c-x>"
   endif

endfunction
