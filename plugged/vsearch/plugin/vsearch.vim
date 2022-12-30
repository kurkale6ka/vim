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
   " After *                i^r/ will give me pattern instead of \<pattern\>
   let res = substitute(reg, '^\\<\(.*\)\\>$', '\1', '' )
   if res != reg
      return res
   endif
   " After * on a selection i^r/ will give me pattern instead of \Vpattern
   let res = substitute(reg, '^\\V'          , ''  , '' )
   let res = substitute(res, '\\\\'          , '\\', 'g')
   let res = substitute(res, '\\n'           , '\n', 'g')
   return res
endfunction
inoremap <silent> <c-r>/ <c-r>=Del_word_delims()<cr>
cnoremap          <c-r>/ <c-r>=Del_word_delims()<cr>

vnoremap <kmultiply> :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap *           :<C-u>call <SID>VSetSearch()<CR>/<CR>
vnoremap #           :<C-u>call <SID>VSetSearch()<CR>?<CR>
