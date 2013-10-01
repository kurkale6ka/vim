" gm improved: moves to    ^...gm...$
"              instead of g0...gm...g$
function! move#gm()
   execute 'normal! ^'
   let first_col = virtcol('.')
   execute 'normal! g_'
   let last_col  = virtcol('.')
   execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction
