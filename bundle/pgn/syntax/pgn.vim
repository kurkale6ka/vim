syntax clear

syntax case ignore

" Folding
syntax region chessGameFold start=/^[[:space:]]*[[[:space:]]*Date/ end=/\n\ze[[:space:]]*[[[:space:]]*Event/ transparent fold

" ???
syntax keyword Normal Event Site Date Round White Black Result Annotator PlyCount TimeControl Time Termination Mode FEN

" Tag value: [key "value"]
syntax match Define /".*"/

" Comments: ;, {}
syntax match  chessComments /;.*$/
syntax region chessComments start=/{/ end=/}/

highlight link chessComments Comment

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
