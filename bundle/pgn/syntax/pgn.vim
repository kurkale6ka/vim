syntax clear

syntax case ignore

syntax match Comment /[[:digit:]]\+\./
" Good move
syntax match Boolean /\%([[:digit:]]\+\..\{-4,}\)\@<=![!?]\?/
" Bad move
syntax match Error   /\%([[:digit:]]\+\..\{-4,}\)\@<=?[?!]\?/
" Rook, Knight, Bishop, Queen, King or file
syntax match Folded /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\%([x:]\?[a-h][1-8]\)\@=/
" Capture
syntax match Debug /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\@<=[x:]/
" Chess board case
syntax match Define /[a-h][1-8]/
" En passant
syntax match Conditional /e\.\?p\.\?/
syntax match Constant /[=#]\|++\?\|[0O]-[0O]\%(-[0O]\)\?/

" syntax region pgnString start=/"/ end=/"/ contained
" syntax region pgnTag start=/\[/ end=/\]/ contains=pgnString
" syntax match pgnResult /[0-2]\/*[0-2]*[-][0-2]\/*[0-2]*/

" highlight link pgnTag Type
" highlight link pgnString Statement
" highlight link pgnSymbol Special
" highlight link pgnResult String
