" Find files
function! find#files(...)
   if a:0 == 1
      let filename = a:1
      execute "args `find . -iname '*".filename."*' -print`"
   elseif a:0 == 2
      let path     = a:1
      let filename = a:2
      execute 'args `find '.path." -iname '*".filename."*' -print`"
   endif
endfunction
