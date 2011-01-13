nmap <leader>e     :set spell!     spell?<cr>
nmap <leader>dg    :set digraph! digraph?<cr>
nmap <leader>p     :set invpaste   paste?<cr>
nmap <leader><tab> :set invlist     list?<cr>

if version >= 703

   function! s:Toggle_number()

      if !&relativenumber

         set relativenumber relativenumber?
      else
         set number number?
      endif

   endfunction

   nmap <leader>n :call <sid>Toggle_number()<cr>

   " Highlight text beyond the 80th column (<leader>c)
   function! s:Toggle_colorcolumn ()

      if empty(&colorcolumn)

         set colorcolumn=+1
         let @/ = '\%81v.*'
      else
         set colorcolumn=
         let @/ = ''
      endif

   endfunction

   nmap <silent> <leader>8 :call <sid>Toggle_colorcolumn()<cr>
endif

" todo: toggle (use '/" function)
nmap <leader>/ :substitute:\\:/:g<cr>
xmap <leader>/ :substitute:\%V\\:/:g<cr>

function! Toggle_quotes () range

   let last_search = histget('search', -1)

   if a:firstline != a:lastline

      let endline = a:lastline - a:firstline + 1
   else
      let endline = v:count1
   endif

   for i in range(1, endline)

      if -1 != match(getline('.'), '"')

         substitute/"/'/ge
      else
         substitute/'/"/ge
      endif
      +
   endfor

   let virtualedit_bak = &virtualedit
   set virtualedit=

   silent! call repeat#set(":call Toggle_quotes()\<cr>")

   " Restore saved values
   let &virtualedit = virtualedit_bak

   if histget('search', -1) != last_search

      call histdel('search', -1)
   endif

endfunction

" Replace all " by '
nmap <leader>' :call Toggle_quotes()<cr>
xmap <leader>' :call Toggle_quotes()<cr>

" Toggle between completeopt+=preview and completeopt-=preview
" mnemo - 'same' behaviour as F4 used in Dolphin KDE
nmap <f4>      :call <sid>Toggle_Longest_Preview('f4')<cr>
imap <f4> <c-o>:call <sid>Toggle_Longest_Preview('f4')<cr>

" Toggle between completeopt+=longest and completeopt-=longest
nmap <f12>      :call <sid>Toggle_Longest_Preview('f12')<cr>
imap <f12> <c-o>:call <sid>Toggle_Longest_Preview('f12')<cr>

function! s:Toggle_Longest_Preview(key)

   if a:key == 'f12'

      if &completeopt =~ 'longest'

         set   completeopt-=longest
         set   showfulltag
         echo 'completeopt - longest (Zend_Acl)'
      else
         set   completeopt+=longest
         set   noshowfulltag
         echo 'completeopt + longest (Zend_)'
      endif

   elseif a:key == 'f4'

      if &completeopt =~ 'preview'

         set   completeopt-=preview
         echo 'completeopt - preview'
      else

         set   completeopt+=preview
         echo 'completeopt + preview window'
      endif
   endif

endfunction
