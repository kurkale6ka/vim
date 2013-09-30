function! copy#line()
   let line = substitute(getline('.'), '^[[:space:]:]\+\|[[:space:]]\+$', '', '')
   call histadd(':', line)
   return line
endfunction

function! copy#selection()
   " Similar to C and D when acting on a visual column (area of width 1)
   if "\<c-v>" == visualmode()
      normal! gv$y
   else
      normal! gvY
   endif
endfunction
