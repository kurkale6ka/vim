" Ctrl + w
" Make it wipeout more, like in readline
function! cmdline#ctrl_w()
   let cmd_r = strpart(getcmdline(), getcmdpos() - 1)
   let cmd_l = split(strpart(getcmdline(), 0, getcmdpos() - 1))
   if len(cmd_l) > 1
      let cmd_l = remove(cmd_l, 0, -2)
      let cmd_left = join(cmd_l)
      call setcmdpos(len(cmd_left) + 2)
      return cmd_left . ' ' . cmd_r
   else
      call setcmdpos(1)
      return cmd_r
   endif
endfunction

" Alt + d
" Delete the word in front of the cursor
function! cmdline#alt_d()
   let cmd_l = strpart(getcmdline(), 0, getcmdpos() - 1)
   let cmd_r = strpart(getcmdline(), getcmdpos() - 1)
   let cmd_r = substitute(cmd_r, '^.\{-}\w\+', '', '')
   call setcmdpos(len(cmd_l) + 1)
   return cmd_l . cmd_r
endfunction

" Switch between command line commands
" Note: switch is not fully functional yet, all it does is copy the pattern in "*
function! cmdline#switch(c)
   normal! 0
   " Copy the pattern of a :s/pattern or :g/pattern
   if search('^\s*\%(g\%[lobal]\|s\%[ubstitute]\)/[^/]', 'e', line('.'))
      if search('/', 'n', line('.'))
         execute 'normal! "*yt/'
      else
         execute 'normal! "*y$'
      endif
   " Copy the pattern of a /
   else
      execute 'normal! "*y$'
   endif
   quit
   redraw!
   " Scenarios: /regex<c-g>      => I intended to use :g/regex   Vs a search
   "            :g/regex<c-r>    => I intended to use :s/regex// Vs :g/regex
   "            :s/old/new/<c-/> => I intended to use /regex     Vs a substitute
   "            ...
   " if a:c == 'g'
   "    execute 'global/'.getreg('*')
   " elseif a:c == 'r'
   "    execute 'substitute/'.getreg('*')."//gc\<left>\<left>\<left>"
   " else
   "    " let @/ = getreg('*')
   "    execute '/'.getreg('*')
   " endif
endfunction

" Move to my vimrc when fully functional
" cmap <silent> <c-s> <c-f>:call cmdline#switch('r')<cr>
" cmap <silent> <c-/> <c-f>:call cmdline#switch('s')<cr>
