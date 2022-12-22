" Delete the extra char added when using <space> to trigger an abbreviation
function! abbreviations#eat_char(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
