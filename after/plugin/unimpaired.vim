if !exists("g:loaded_unimpaired")
   finish
endif

nunmap [p
nunmap ]p

nmap yov :se <C-R>=(&ve != 'all') ? 've=all' : 've=block'<CR><CR>
