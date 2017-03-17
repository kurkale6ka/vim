" Delete EOL white spaces
function! spaces#remove()

   let save_cursor = getpos('.')

   silent! %substitute/\s\+$//e

   call histdel('search', -1)
   call setpos('.', save_cursor)

endfunction

" Delete EOF empty lines
function! spaces#remove_eof()

   let save_cursor = getpos('.')

   silent! %substitute/\_s*\%$//e

   call histdel('search', -1)
   call setpos('.', save_cursor)

endfunction
