syntax clear

syntax case ignore

syntax match Comment /[[:digit:]]\+\./

" Good move
syntax match Boolean /![!?]\?/
" syntax match Boolean /\%([[:digit:]]\+\..\{-4,}\)\@<=![!?]\?/

" Bad move
syntax match WarningMsg /?[?!]\?/
" syntax match ErrorMsg /\%([[:digit:]]\+\..\{-4,}\)\@<=?[?!]\?/

" Left piece: Rook, Knight, Bishop, Queen, King or file
syntax match Folded /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\%([x:]\?[a-h][1-8]\)\@=/
" syntax match Folded /\%([[:digit:]]\+\..\{-4,}\)\@<=\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\%([x:]\?[a-h][1-8]\)\@=/

" Capture
syntax match Debug /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\@<=[x:]/

" Chess board case
syntax match Define /[a-h][1-8]/

" En passant
syntax match Conditional /e\.\?p\.\?/

" Check
syntax match Constant /++\?/

" Castling
syntax match Constant /0-0\%(-0\)\?\|O-O\%(-O\)\?/

" =
" Comments
" ...
" #
" 1-0, 0-1, ½-½
" Put together 1-0, x and # ?
