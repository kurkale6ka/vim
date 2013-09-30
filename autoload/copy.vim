function! copy#line()
   let line = substitute(getline('.'), '^[[:space:]:]\+\|[[:space:]]\+$', '', '')
   call histadd(':', line)
   return line
endfunction

function! copy#block()
   if "\<c-v>" == visualmode()
      normal! gv$y
   else
      normal! gvY
   endif
endfunction
