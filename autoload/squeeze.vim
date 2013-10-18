" Squeeze empty lines (TODO: remove entries from / history)
function! squeeze#lines(mode)
   let save_cursor = getpos('.')
   if a:mode == 'v'
      let save_search = @/
      *vglobal/\S/delete
      let @/ = save_search
   else
      " empty lines at BOF|EOF
      silent %substitute/\%^\_s*\n\|\_s*\%$//
      " empty line clusters
      silent global/^\%(\s*$\n\)\{2,}/delete
   endif
   call setpos('.', save_cursor)
endfunction
