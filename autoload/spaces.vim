function! spaces#remove()
   let save_cursor = getpos('.')
   let save_search = @/
   silent! %substitute/\s\+$//e
   let @/ = save_search
   call setpos('.', save_cursor)
endfunction
