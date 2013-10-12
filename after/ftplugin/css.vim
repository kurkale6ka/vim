setlocal iskeyword+=-

imap <silent> <buffer> <localleader><localleader> /*  */<left><left><left>
imap <silent> <buffer> <localleader>cs            /*<cr><cr>/<left><up><space>

" rearrange this kind of patterns vertically:
" -------------------------------------------
"
"     h1, span, div, a { white-space : normal ; width : auto }
"
"     Note: to be used on the first line of the pattern
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

"let @r="^d0/}\<cr>v``:j\<cr>:s/\\s*\\(,\\)\\s*/\\1\\r/ge\<cr>:s/\\s*\\ze{/\\r\<cr>:s/\\_.\\{-}\\zs\\s*\\ze}/\\r\<cr>-:s/\\%({\\|;\\%(\\s*$\\)\\@!\\)\\zs\\s*/\\r/g\<cr>=iB:Tabularize css\<cr>]}/\\S\<cr>:nohlsearch\<cr>-+"

" Version without vertical alignment
let @r="^d0/}\<cr>v``:j\<cr>:s/\\s*\\(,\\)\\s*/\\1\\r/ge\<cr>:s/\\_.\\{-}\\zs\\s*\\ze}/\\r\<cr>-:s/\\%({\\|;\\%(\\s*$\\)\\@!\\)\\zs\\s*/\\r/g\<cr>=iB]}/\\S\<cr>:nohlsearch\<cr>-+"

" Result:
"
"     h1,
"     span,
"     div,
"     a {
"         white-space:normal;
"         width:auto
"     }
