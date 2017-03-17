" Squeeze empty lines
function! squeeze#lines(mode)

   let save_cursor = getpos('.')

   if a:mode == 'v'

      *vglobal/\S/delete

      call histdel('search', -1)
   else
      " empty lines at BOF|EOF
      silent %substitute/\%^\_s*\n\|\_s*\%$//

      " clusters of empty lines
      silent global/^\%(\s*$\n\)\{2,}/delete

      call histdel('search', -1)
      call histdel('search', -1)
   endif

   call setpos('.', save_cursor)

endfunction
