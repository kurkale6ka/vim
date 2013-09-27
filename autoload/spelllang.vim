function! spelllang#bg()
   if &keymap != ''
      setlocal keymap& spelllang&
   else
      setlocal keymap=bg
   endif
endfunction
