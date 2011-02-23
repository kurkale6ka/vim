syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=.*[^.?!:]\%(\n^[[:space:]]*$\)\@=/

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
syntax match txtAcronym /\<\u\{2,}\>/

highlight link txtTitle   Statement
highlight link txtLink    Underlined
highlight link txtEmail   Underlined
" highlight txtList term=bold cterm=bold gui=bold
highlight link txtList    Constant
highlight link txtAcronym Type
highlight link txtNote    PreProc

highlight link txtSectionDelimiter helpSectionDelim
