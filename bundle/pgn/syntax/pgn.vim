syntax clear

syntax case ignore

syntax match Comment /[[:digit:]]\+\./
" Good move
syntax match Boolean /\%([[:digit:]]\+\..\{-4,}\)\@<=![!?]\=/
" Bad move
syntax match Error   /\%([[:digit:]]\+\..\{-4,}\)\@<=?[?!]\=/
" Rook, Knight, Bishop, Queen or King
syntax match ColorColumn /\%([RNBQK]\%([a-h][1-8]\=\)\=\)\%([x:]\=[a-h][1-8]\)\@=/
syntax match Debug /[x:]/
" Chess board case
syntax match Define /[a-h][1-8]/
syntax match Conditional /e\.\=p\.\=/
syntax match Constant /[=#]\|++\=\|[0O]-[0O]\%(-[0O]\)\=/

" syntax region pgnString start=/"/ end=/"/ contained
" syntax region pgnTag start=/\[/ end=/\]/ contains=pgnString
" syntax match pgnResult /[0-2]\/*[0-2]*[-][0-2]\/*[0-2]*/

" highlight link pgnTag Type
" highlight link pgnString Statement
" highlight link pgnSymbol Special
" highlight link pgnResult String
