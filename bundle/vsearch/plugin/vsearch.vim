" vsearch.vim
" Visual mode search
function! s:VSetSearch()
   " Save default register (")
   let temp = @@
   normal! gvy
   " Very nomagic mode: \$, \., \* ... are special so by escaping \,
   " everything is literal. Also, replace newlines with \n
   let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
   " Use this line instead of the above to match matches spanning across lines
   "let @/ = '\V' . substitute(escape(@@, '\'), '\_s\+', '\\_s\\+', 'g')
   call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
   let @@ = temp
endfunction

function! Del_word_delims()
   let reg = getreg('/')
   " After * on a selection i^r/ will give me pattern instead of \Vpattern
   let reg = substitute(reg, '^\\V'                                 , ''  , '' )
   let reg = substitute(reg, '\\\\'                                 , '\\', 'g')
   let reg = substitute(reg, '\\n'                                  , '\n', 'g')
   " After *                i^r/ will give me pattern instead of \<pattern\>
   let reg = substitute(reg, '^\\<\%(.*\\>\)\@=\|\%(\\<.*\)\@<=\\>$', ''  , 'g')
   return reg
endfunction
noremap! <c-r>/ <c-r>=Del_word_delims()<cr>

vnoremap <kmultiply> :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap *           :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap #           :<C-u>call <SID>VSetSearch()<CR>?<CR>
