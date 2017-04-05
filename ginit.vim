let $MYGVIMRC = '~/github/vim/ginit.vim'

" Font
Guifont DejaVu Sans Mono:h12

" Any unicode stuff must be repeated here as there is no such test as
" has('gui_running') for nvim-qt!

let &showbreak = nr2char(8618).' ' " U+21AA ↪

let s:arr = nr2char(9655) " U+25B7: ▷
let s:dot = nr2char(8901) " U+22C5: ⋅

" Show tabs as ▷⋅⋅⋅ and spaces as ⋅ in list view
execute 'set listchars=tab:'    .s:arr.s:dot
execute 'set listchars+=trail:' .s:dot
execute 'set listchars+=nbsp:'  .s:dot

" Status line
set statusline=%!statusline#init('❬',\ '❭')
