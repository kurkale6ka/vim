" Print characters corresponding to a numeric range:
" e.g. call ascii#codes(21,31)
"
" ASCII   control characters: character code 0-31
" ASCII printable characters: character code 32-127
" Extended ASCII codes:       character code 128-255
function! ascii#codes (...)

   if a:0 == 0
      view $HOME/.vim/extra/ascii
      return
   endif

   let codes =
      \{0:'^@', 9:'^I', 10:'^J (^@)', 13:'^M', 32:'<space>', 127:'<del>', 160:'&nbsp'}

   if a:0 != 2
      for code in a:000
         echon '['. code .' '
         echohl Comment
         if has_key(codes, code)
            echon codes[code]
         else
            echon nr2char(code)
         endif
         echohl Normal
         echon '] '
      endfor
   else
      for code in range(a:1, a:2)
         echon '['. code .' '
         echohl Comment
         if has_key(codes, code)
            echon codes[code]
         else
            echon nr2char(code)
         endif
         echohl Normal
         echon '] '
      endfor
   endif

endfunction
