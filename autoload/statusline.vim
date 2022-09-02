function! statusline#init(sep_l, sep_r)

   " Colors (highlight groups):
   " %[1-9]* ... %*
   " for i in range(1,9) | exe 'hi User'.i | endfor

   let statusline  = "%<%1*%L%* " " number of lines

   " paste mode
   let statusline .= "%2*".a:sep_l."%* %4*%{empty(&paste)?'':'--paste-- '}%*"
   let statusline .= "%3*%t%*" " file name

   " git branch
   let statusline .= "%6*%{statusline#git()}%*"

   " RO, modified, modifiable
   let statusline .= "%{empty(&ro) && empty(&mod) && !empty(&ma) && empty(&kmp)?'':' '}%4*%r%m%*"
   " keymap
   let statusline .= "%{empty(&kmp)?'':'('.b:keymap_name.')'}"

   let statusline .= " %2*".a:sep_l."%* %v" " column

   " alternate file
   let statusline .= "%=%3*%{expand('#:t') != expand('%:t') && !empty(expand('#:t'))?'#'.expand('#:t'):''}%*"
   let statusline .= "%2*%{expand('#:t') != expand('%:t') && !empty(expand('#:t'))?'  ".a:sep_r." ':''}%*"

   " filetype and fileformat
   let statusline .= "%5*%{&ft}%*"
   let statusline .= "%2*%{&ff != 'unix' && !empty(&ft)?'-':''}%*%4*%{&ff != 'unix'?&ff:''}%*"

   " percentage through file
   let statusline .= "%2*%{empty(&ft) && &ff == 'unix'?'':'  ".a:sep_r." '}%*%P"

   return statusline

endfunction

function! statusline#git()
   let branch = FugitiveStatusline()
   if !empty(branch) && branch !~ 'master\|main\|trunk'
      return ' '.substitute(branch, '\[Git(\(.\+\))\]', '\1', '')
   else
      return ''
   endif
endfunction
