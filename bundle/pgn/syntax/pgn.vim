syntax clear

syntax case match

" Folding
syntax region ChessGameFold start=/^[[:space:]]*\[[[:space:]]*Date/ end=/\n\ze[[:space:]]*\[[[:space:]]*Event/ transparent fold

syntax keyword ChessKeyword Event Site Date Round White Black Result Annotator PlyCount TimeControl Time Termination Mode FEN

" Normal ???
highlight link ChessKeyword Normal

" Tag value: [key "value"]
syntax match ChessString /".*"/

highlight link ChessString PreProc

" Comments: ;, {}
syntax match  ChessComment /;.*$/
syntax region ChessComment start=/{/ end=/}/

highlight link ChessComment Comment

" Move number: 1.
syntax match ChessMoveNumber /[[:digit:]]\+[[:space:]]*\.\%(\.\.\)\?/

highlight link ChessMoveNumber LineNr

" Good move: !?, !, !!
syntax match ChessGoodMove /![!?]\?/

highlight link ChessGoodMove Type

" Bad move: ?!, ?, ??
syntax match ChessBadMove /?[?!]\?/

highlight link ChessBadMove WarningMsg

" " White move background: 3. (Nc3xb5) ---
" syntax match ChessWhite /\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=\%([RNBQK]\%([a-h][1-8]\?\)\?x\?[a-h][1-8]\)/

" " File: (f)xg4
" syntax match ChessWhite /\%(^[[:space:]]*[[:digit:]]\+[[:space:]]*\.[[:space:]]*\)\@<=\%([a-h]x[a-h][1-8]\)/

" highlight ChessWhite guibg=#ffcc99

" " Black move background: 3... (Rh5)
" syntax match ChessBlack /[RNBQK]\%([a-h][1-8]\?\)\?x\?[a-h][1-8]/

" " File: (f)xg4
" syntax match ChessBlack /[a-h]x[a-h][1-8]/

" highlight ChessBlack guibg=#cc9966

" Rook, kNight, Bishop, Queen, King
" Ex: N, Nc, Nc3
syntax match ChessStrongPiece /\%([RNBQK]\%([a-h][1-8]\?\)\?\)\%(x\?[a-h][1-8]\)\@=/

highlight link ChessStrongPiece Statement

" File: (f)xg4
syntax match ChessFile /[a-h]\%(x[a-h][1-8]\)\@=/

highlight link ChessFile Statement

" Pawn / case: d3
syntax match ChessCase /\<[a-h][1-8]\>\|\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)\@<=[a-h][1-8]/

highlight link ChessCase Special

" Castling: O-O, O-O-O
syntax match ChessCastling /0-0\%(-0\)\?\|O-O\%(-O\)\?/

highlight link ChessCastling Statement

" Capture, check, checkmate, promotion, en passant
syntax match ChessAction /[x#=]\|++\?\|e\.\?p\.\?/

highlight link ChessAction Constant

" Result
syntax match ChessResult #1-0\|½-½\|1/2-1/2\|0-1#

highlight link ChessResult CursorLine

" Errors
" One error at a time, several won't be highlighted
" Note: \zs and \ze do not work here (bug?)

" RNBQK wrong case: bad rank
syntax match ChessError /\%(\%([RNBQK][a-h]\)\@<=[09]\)\%(x\?[a-h][1-8]\)\@=/

" RNBQK wrong case: bad file
" no rank
syntax match ChessError /\%([RNBQK]\@<=[^a-h]\)\%(x[a-h][1-8]\)\@=/
syntax match ChessError /\%([RNBQK]\@<=[^a-hx]\)\%([a-h][1-8]\)\@=/
" rank: caught below (Wrong case: bad file)

" RNBQK: bad piece
syntax match ChessError /\<[^RNBQKa-h]\%(x[a-h][1-8]\>\)\@=/
syntax match ChessError /\<[^RNBQK]\%([a-h][1-8]\>\)\@=/
syntax match ChessError /[^RNBQK[:space:]]\%([a-h][1-8]\?x\?[a-h][1-8]\)\@=/

" Wrong case: bad rank
syntax match ChessError /\%(\<[a-h]\)\@<=[09]\>\|\%(\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)[a-h]\)\@<=[09]/

" Wrong case: bad file
syntax match ChessError /\<[^a-h[:digit:]]\%([1-8]\>\)\@=\|\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)\@<=[^a-h[:space:]][1-8]\@=/

" Unknown tag key
syntax match ChessError /^[[:space:]]*\[[[:space:]]*\%(\%(Event\|Site\|Date\|Round\|White\|Black\|Result\|Annotator\|PlyCount\|TimeControl\|Time\|Termination\|Mode\|FEN\)\>\)\@!/

" Bad result
syntax match ChessError /\%("[[:space:]]*\)\?1-1\%([[:space:]]*"\)\?/

highlight link ChessError ErrorMsg
