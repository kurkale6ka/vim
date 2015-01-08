function! highlight#column()
   if empty(&colorcolumn)
      if empty(&textwidth)
         setlocal colorcolumn=81
         let @/ = '\%81v.*'
      else
         setlocal colorcolumn=+1
         let @/ = '\%'.(&textwidth + 1).'v.*'
      endif
   else
      setlocal colorcolumn=
      let @/ = ''
   endif
endfunction
