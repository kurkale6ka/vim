syntax clear

syntax case ignore

" Comments: ;, {}
syntax match  Comment /;.*$/
syntax region Comment start=/{/ end=/}/

" Tag value: [key "value"]
syntax match Define /".*"/

" Move number: 1.
syntax match LineNr /[[:digit:]]\+[[:space:]]*\.\%(\.\.\)\?/

" Good move: !?, !, !!
syntax match StorageClass /![!?]\?/

" Bad move: ?!, ?, ??
syntax match WarningMsg /?[?!]\?/

" Any piece move/take: Ng2[xf4]
syntax match Keyword /\%([RNBQKa-h]\%([a-h][1-8]\?\)\?\)\%(x\?[a-h][1-8]\)\@=/

" Pawn move: e5
syntax match Special /[a-h][1-8]/

" Castling: O-O
syntax match Keyword /0-0\%(-0\)\?\|O-O\%(-O\)\?/

" Capture, check, checkmate, promotion, en passant
syntax match Constant /[x#=]\|++\?\|e\.\?p\.\?/

" Result
syntax match CursorLine #1-0\|½-½\|1/2-1/2\|0-1#
