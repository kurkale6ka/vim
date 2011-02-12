syntax clear

syntax case match

" Folding
syntax region chessGameFold start=/^[[:space:]]*\[[[:space:]]*Date/ end=/\n\ze[[:space:]]*\[[[:space:]]*Event/ transparent fold

" ???
syntax keyword Normal Event Site Date Round White Black Result Annotator PlyCount TimeControl Time Termination Mode FEN

" Tag value: [key "value"]
syntax match Define /".*"/

" Comments: ;, {}
syntax match  ChessComment /;.*$/
syntax region ChessComment start=/{/ end=/}/

highlight link ChessComment Comment

" Move number: 1.
syntax match LineNr /[[:digit:]]\+[[:space:]]*\.\%(\.\.\)\?/

" Good move: !?, !, !!
syntax match StorageClass /![!?]\?/

" Bad move: ?!, ?, ??
syntax match WarningMsg /?[?!]\?/

" " White move background
" syntax match ChessWhite /\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=\%([RNBQK]\%([a-h][1-8]\?\)\?x\?[a-h][1-8]\)/

" " File
" syntax match ChessWhite /\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=\%([a-h]x[a-h][1-8]\)/

" highlight ChessWhite guibg=#ffcc99

" " Black move background
" syntax match ChessBlack /[RNBQK]\%([a-h][1-8]\?\)\?x\?[a-h][1-8]/

" " File
" syntax match ChessBlack /[a-h]x[a-h][1-8]/

" highlight ChessBlack guibg=#cc9966

" Rook, kNight, Bishop, Queen, King
syntax match Keyword /\%([RNBQK]\%([a-h][1-8]\?\)\?\)\%(x\?[a-h][1-8]\)\@=/

" Pawn
syntax match Special /[a-h][1-8]/

" File
syntax match Keyword /[a-h]\%(x[a-h][1-8]\)\@=/

" Castling: O-O
syntax match Keyword /0-0\%(-0\)\?\|O-O\%(-O\)\?/

" Capture, check, checkmate, promotion, en passant
syntax match Constant /[x#=]\|++\?\|e\.\?p\.\?/

" Result
syntax match CursorLine #1-0\|½-½\|1/2-1/2\|0-1#

" Illegal text ???
syntax match ChessMoveError /\%([RNBQK][a-h]\zs[^1-8]\ze\)\%(x\?[a-h][1-8]\)\@=/
syntax match ChessMoveError /\%([RNBQK][a-h][1-8]\)\@<=\%(x\?[a-h]\zs[^1-8]\ze\)/
syntax match ChessMoveError /[a-h]x[a-h]\zs[^1-8]\ze/

highlight link ChessMoveError ErrorMsg
