" function! register#append(reg)
"    call setreg(a:reg, '')
"    execute 'nnoremap <silent> <buffer> y :call register#copy("y", "'.a:reg.'")<cr>'
"    execute 'xnoremap <silent> <buffer> y :call register#copy("y", "'.a:reg.'")<cr>'
"    execute 'onoremap <silent> <buffer> y :call register#copy("y", "'.a:reg.'")<cr>'
"
"    execute 'nnoremap <silent> <buffer> yy :call register#copy("yy", "'.a:reg.'")<cr>'
"    execute 'xnoremap <silent> <buffer> yy :call register#copy("yy", "'.a:reg.'")<cr>'
"    execute 'onoremap <silent> <buffer> yy :call register#copy("yy", "'.a:reg.'")<cr>'
"
"    execute 'nnoremap <silent> <buffer> p :call register#paste("'.a:reg.'")<cr>'
" endfunction
"
" command! -nargs=? Append call register#append(<f-args>)

function! register#copy(op, reg)
   if getreg(a:reg) == ''
      if a:op == 'yy'
         execute 'normal! "'.a:reg.'yy'
      else
         execute 'normal! "'.a:reg.'y'
      endif
   else
      if a:op == 'yy'
         execute 'normal! "'.toupper(a:reg).'yy'
      else
         execute 'normal! "'.toupper(a:reg).'y'
      endif
   endif
endfunction

function! register#paste(reg)
   execute 'normal! "'.a:reg.'p'
   silent! unmap <buffer> y
   silent! unmap <buffer> yy
   silent! unmap <buffer> p
endfunction
