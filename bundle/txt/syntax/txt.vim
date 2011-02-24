syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=\u.*[^.?!:]\%(\n^[[:space:]]*$\)\@=/

syntax match txtLink "\<\%(https\?\|ftp\)://\%(www\.\)\?[-[:alnum:]_.#~+/]\+\%(?[-[:alnum:][:xdigit:]_.~+=&;]\+\)\?"

syntax match txtEmail "[-[:alnum:]_#~+]\+\%(\.[-[:alnum:]_#~+]\+\)\?@[-[:alnum:]_#~+]\+\.[-[:alnum:]_#~+]\+"

" --------------------------------------------------------------
syntax match txtSectionDelimiter /^[[:space:]]*-\+[[:space:]]*$/

" Lists:
" * / - / 1.
" * / - / 2.
syntax match txtList /^[[:space:]]*\%([*-]\|\%([[:digit:]]\+\|[[:lower:]]\)[.)]\?\)[[:space:]]\+/

" Note:
syntax match txtNote /^.\+:[[:space:]]*$/

" UCPA
syntax match txtAcronym /\<[[:upper:]]\{2,}\>/

" Numbers
syntax match txtNumber /[[:digit:]]\+/

syntax match txtBaseFileName "\<\%(\f\+\.[[:alpha:]]\+\|README\)\>"
" Unix file
syntax match txtFile "\%(\~\?/\|\.\.\?/\)\%(\%(\.\.\?\|\f\+\)/\)*\f\+\%(\.[[:alpha:]]\+\)\?"
" Unix directory
syntax match txtDirectory "\%(\.\.\?\|\f\)\+/\>"

highlight link txtBaseFileName Comment
highlight link txtFile Comment
highlight link txtDirectory Comment

highlight link txtTitle   Statement
highlight link txtLink    Underlined
highlight link txtEmail   Underlined
" highlight txtList term=bold cterm=bold gui=bold
highlight link txtList    Constant
highlight link txtNumber  Constant
highlight link txtAcronym Type
highlight link txtNote    PreProc

highlight link txtSectionDelimiter helpSectionDelim
