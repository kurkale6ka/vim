" Blanking lines
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/blanklines.vim

function! s:BlankLines(mode) range

   let operation = 'normal! 0Dj'

   if a:firstline != a:lastline

      let endline = a:lastline - a:firstline + 1
   else
      let endline = v:count1
   endif

   for i in range(1, endline)

      execute operation
   endfor

   let virtualedit_bak = &virtualedit
   set virtualedit=

   if 'v' == a:mode

      silent! call repeat#set("\<plug>BlanklinesVBlank")
   else
      silent! call repeat#set("\<plug>BlanklinesNBlank")
   endif

   let &virtualedit = virtualedit_bak

endfunction

nmap <silent> <plug>BlanklinesNBlank :call <sid>BlankLines('n')<cr>
xmap <silent> <plug>BlanklinesVBlank :call <sid>BlankLines('v')<cr>

nmap <leader>dd <plug>BlanklinesNBlank
xmap <leader>dd <plug>BlanklinesVBlank
