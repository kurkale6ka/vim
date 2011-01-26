set nonumber norelativenumber

iabbrev oo  O-O
iabbrev OO  O-O
iabbrev 00  O-O
iabbrev ooo O-O-O
iabbrev OOO O-O-O
iabbrev 000 O-O-O

" ♔ ♚  ♕ ♛  ♖ ♜  ♗ ♝  ♘ ♞  ♙ ♟

" command! -range=% Figures call tr(

function! s:NumberIncrement()

   let move_number =
      \search('^[[:space:]]*[[:digit:]]\+[[:space:]]*\.\%(.\+[[:digit:]]\+[[:space:]]*\.\)\@!',
      \'bcn',
      \line('.') - 1)

   if move_number

      let curr_line = getline(move_number)
      let next_move_number = strpart(curr_line, 0, stridx(curr_line, '.')) + 1
      return next_move_number . '. '
   else
      return ''
   endif

endfunction

inoremap <cr> <cr><c-r>=<sid>NumberIncrement()<cr>
