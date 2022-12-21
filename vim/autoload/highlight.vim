function! highlight#column()
   if empty(&colorcolumn)
      setlocal colorcolumn=0
      if empty(&textwidth)
         match ColorColumn /\%81v[^\t]/
         let @/ = '\%81v.*'
      else
         execute 'match ColorColumn /\%'.(&textwidth + 1).'v[^\t]/'
         let @/ = '\%'.(&textwidth + 1).'v.*'
      endif
   else
      setlocal colorcolumn=
      match none
      let @/ = ''
   endif
endfunction
