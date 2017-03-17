function! spaces#remove()

   let save_cursor = getpos('.')

   silent! %substitute/\s\+$//e

   call histdel('search', -1)
   call setpos('.', save_cursor)

endfunction
