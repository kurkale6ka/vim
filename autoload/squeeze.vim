" Squeeze empty lines (TODO: remove entries from / history)
function! squeeze#lines()
   let save_cursor = getpos('.')
   " empty lines at BOF|EOF
   silent  %substitute/\%^\_s*\n\|\_s*\%$//
   " empty line clusters
   silent   global/^\%(\s*$\n\)\{2,}/delete
   call setpos('.', save_cursor)
endfunction
