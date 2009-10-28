set iskeyword+=-

" rearrange this kind of patterns vertically:
" -------------------------------------------
"
"     h1, span, div, a { white-space : normal ; width : auto }
"
"     h1, span, div, a
"     { white-space : normal ; width : auto }
"
"     h1, span, div, a {
"     white-space : normal ; width : auto }
"
" Result:
"
"     h1,
"     span,
"     div,
"     a
"     {
"         white-space : normal ;
"         width       : auto
"     }

let @r="^d0:s/\\s*\\(,\\)\\s*/\\1\\r/ge\<cr>:s/\\_s*\\ze{/\\r/ge\<cr>:s/\\_s*{\\_[^{]\\{-}\\zs\\s*\\ze}/\\r/ge\<cr>=`[w:s/[{;]\\%(\\s*$\\)\\@!\\zs\\s*/\\r/ge\<cr>=iBw:nohlsearch\<bar>Tabularize css\<cr>``+EB"
