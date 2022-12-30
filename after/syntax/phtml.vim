   " autocmd Syntax phtml
   "    \ syntax clear htmlLink
   "    \ syntax region htmlLink start=/<a\_[[:space:]]\+\_[^>]\{-}\<href\_.\{-}>\_[[:space:]]*/hs=e+1 end="\_[[:space:]]*</a>"he=s-1 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc
