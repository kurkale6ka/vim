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
syntax match ChessGoodMoveBlack /\%(\%(\d\.\s*\)\@<!\%(\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)[a-h][1-8]\|\<[a-h][1-8]\>\)\)\@<=[[:space:]]*![!?]\?/

highlight link ChessGoodMove Type
highlight ChessGoodMoveBlack term=underline cterm=bold ctermfg=72 gui=bold guifg=SeaGreen ctermbg=254 guibg=Grey90

" Bad move: ?!, ?, ??
syntax match ChessBadMove /?[?!]\?/
syntax match ChessBadMoveBlack /\%(\%(\d\.\s*\)\@<!\%(\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)[a-h][1-8]\|\<[a-h][1-8]\>\)\)\@<=[[:space:]]*?[?!]\?/

highlight link ChessBadMove WarningMsg
highlight ChessBadMoveBlack term=standout ctermfg=196 guifg=Red ctermbg=254 guibg=Grey90

" Rook, kNight, Bishop, Queen, King
" Ex: N, (N)c, (N)c3, h8=(Q), axb8=(R)
syntax match ChessStrongPiece /\%([RNBQK]\%([a-h][1-8]\?\)\?\)\%(x\?[a-h][1-8]\)\@=\|\%(\%([a-h]x\)\?[a-h][18]=\)\@<=[RNBQ]/
syntax match ChessStrongPieceBlack /\%(\d\.\s*\)\@<!\%([RNBQK]\%([a-h][1-8]\?\)\?\)\%(x\?[a-h][1-8]\)\@=\|\%(\%(\d\.\s*\)\@<!\%([a-h]x[a-h][18]=\|\<[a-h][18]=\)\)\@<=[RNBQ]/

highlight link ChessStrongPiece Statement
highlight ChessStrongPieceBlack term=bold cterm=bold ctermfg=131 gui=bold guifg=Brown ctermbg=254 guibg=Grey90

" File: (f)xg4
syntax match ChessFile /[a-h]\%(x[a-h][1-8]\)\@=/
syntax match ChessFileBlack /\%(\d\.\s*\)\@<![a-h]\%(x[a-h][1-8]\)\@=/

highlight link ChessFile Statement
highlight ChessFileBlack term=bold cterm=bold ctermfg=131 gui=bold guifg=Brown ctermbg=254 guibg=Grey90

" Pawn / case: d3
syntax match ChessCase /\<[a-h][1-8]\>\|\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)\@<=[a-h][1-8]/
syntax match ChessCaseBlack /\%(\d\.\s*\)\@<!\<[a-h][1-8]\>\|\%(\%(\d\.\s*\)\@<!\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)\)\@<=[a-h][1-8]/

highlight link ChessCase Special
highlight ChessCaseBlack term=bold ctermfg=104 guifg=SlateBlue ctermbg=254 guibg=Grey90

" Castling: O-O, O-O-O
syntax match ChessCastling /0-0\%(-0\)\?\|O-O\%(-O\)\?/
syntax match ChessCastlingBlack /\%(\d\.\s*\)\@<!\%(0-0\%(-0\)\?\|O-O\%(-O\)\?\)/

highlight link ChessCastling Statement
highlight ChessCastlingBlack term=bold cterm=bold ctermfg=131 gui=bold guifg=Brown ctermbg=254 guibg=Grey90

" Capture, check, checkmate, promotion, en passant
syntax match ChessAction /[x#=]\|++\?\|e\.\?p\.\?/
syntax match ChessActionBlack /\%(\%(\d\.\s*\)\@<!\%([RNBQK]\%([a-h][1-8]\?\)\?\|[a-h]\)\)\@<=x\|\%(\%(\d\.\s*\)\@<!\%(\%([RNBQK]\%([a-h][1-8]\?\)\?x\?\|[a-h]x\)[a-h][1-8]\|\<[a-h][1-8]\>\)\)\@<=\%(#\|++\?\|[[:space:]]*e\.\?p\.\?\)\|\%(\%(\d\.\s*\)\@<!\%([a-h]x[a-h][18]\|\<[a-h][18]\)\)\@<==[RNBQ]\@=/

highlight link ChessAction Constant
highlight ChessActionBlack term=underline ctermfg=201 guifg=Magenta ctermbg=254 guibg=Grey90

" Result
syntax match ChessResult #1-0\|½-½\|1/2-1/2\|0-1\|\%(\d\..\{-}\)\@<=\*#

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

" Wrong promotion (rank <> 1/8 or piece <> RNBQ)
syntax match ChessError /\%(\%([a-h]x\)\?[a-h]\)\@<=[^18]\%(=[RNBQ]\)\@=/
syntax match ChessError /\%(\%([a-h]x\)\?[a-h][18]=\)\@<=[^RNBQ]/

" Unknown tag key
syntax match ChessError /^[[:space:]]*\[[[:space:]]*\%(\%(Event\|Site\|Date\|Round\|White\|Black\|Result\|Annotator\|PlyCount\|TimeControl\|Time\|Termination\|Mode\|FEN\)\>\)\@!/

" ... error (1. ... or 1....)
syntax match ChessError /\%(\d\.\)\@<=[[:space:]]\+\%(\.\{3}\)\@=/
syntax match ChessError /\%(\d\.[[:space:]]\+\.\.\)\@<=\./
syntax match ChessError /\%(\d\.\{3}\)\@<=\./

" Bad result
syntax match ChessError /\%("[[:space:]]*\)\?1-1\%([[:space:]]*"\)\?/

highlight link ChessError ErrorMsg
