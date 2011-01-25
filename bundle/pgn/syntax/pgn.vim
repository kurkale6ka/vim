syntax clear

syntax case ignore

" Comments
syntax match  Comment /;.*$/
syntax region Comment start=/{/ end=/}/

" Tag value ([key "value"])
syntax match String /".*"\s*]\@=/

" Move number
syntax match LineNr /[[:digit:]]\+\.\%(\.\.\)\?/

" Good move
syntax match StorageClass /![!?]\?/
" syntax match Boolean /\%([[:digit:]]\+\..\{-4,}\)\@<=![!?]\?/

" Bad move
syntax match WarningMsg /?[?!]\?/
" syntax match ErrorMsg /\%([[:digit:]]\+\..\{-4,}\)\@<=?[?!]\?/

" Left piece: Rook, Knight, Bishop, Queen, King or file
syntax match Keyword /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\%([x:]\?[a-h][1-8]\)\@=/
" syntax match Folded /\%([[:digit:]]\+\..\{-4,}\)\@<=\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\%([x:]\?[a-h][1-8]\)\@=/

" Castling
syntax match Keyword /0-0\%(-0\)\?\|O-O\%(-O\)\?/

" Capture
syntax match Special /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\@<=[x:]/

" Chess board case
syntax match Identifier /[a-h][1-8]/

" En passant
syntax match Conditional /e\.\?p\.\?/

" Check
syntax match Constant /++\?/

" Result
syntax match Typedef #1-0\|½-½\|1/2-1/2\|0-1#

" =
" #
" Put together 1-0, x and # ?
