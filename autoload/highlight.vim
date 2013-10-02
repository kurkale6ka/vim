function! highlight#column81()
   if empty(&colorcolumn)
      if empty(&textwidth)
         setlocal colorcolumn=81
      else
         setlocal colorcolumn=+1
      endif
      let @/ = '\%81v.*'
   else
      setlocal colorcolumn=
      let @/ = ''
   endif
endfunction
