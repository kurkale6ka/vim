syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=[[:upper:]].*[^.?!:]\%(\n^[[:space:]]*$\)\@=/

syntax match txtLink "\<\%(https\?\|ftp\)://\%([-[:alnum:]_#~+/]\+\.\)*[-[:alnum:]_#~+/]\+\%(?[-[:alnum:][:xdigit:]_~+=&;]\+\)\?"

syntax match txtEmail "[-[:alnum:]_#~+]\+\%(\.[-[:alnum:]_#~+]\+\)\?@[-[:alnum:]_#~+]\+\.[-[:alnum:]_#~+]\+"

" Lists:
" * / - / 1.
" * / - / 2.
syntax match txtList /^[[:space:]]*\%([*-]\|[[:digit:]]\+[[:space:]]*[.)]\?\|[[:alpha:]][[:space:]]*[.)]\)/

" Note:
syntax match txtNote /^.\+:[[:space:]]*$/

" ACRONYM
syntax match txtAcronym /\%([[:lower:]].\{-}\)\@<=\<[[:upper:]]\{2,}\>\|\<[[:upper:]]\{2,}\>\%(.\{-}[[:lower:]]\)\@=/

" Numbers
syntax match txtNumber /[[:digit:]]\+/

" Files
" Basename
syntax match txtBaseFileName "\%(\k\+\.[[:alpha:]]\+\|README\)\>"
" Unix relative file path
" syntax match txtFile "\%(\%(\.\.\?\|\k\+\)/\)\+\k\+\%(\.[[:alpha:]]\+\)\?"
" Unix absolute file path
syntax match txtFile "\%(\~\|\.\.\?\)\?/\%(\%(\.\.\|\k\+\)/\)*\k\+\%(\.[[:alpha:]]\+\)\?\>"
" Unix directory
" syntax match txtDirectory "\%(\.\.\?\|\k\+\)/\>"
syntax match Normal "OS\%(/2\)\@="
" Windows absolute file path
syntax match txtFile "[[:alpha:]]:\\\%(\k\+\\\)\+\k\+\%(\.[[:alpha:]]\+\)\?\>"

syntax region txtString start=/\z(["`]\|'\%(s\>\)\@!\)/ skip=/\\\z1/ end=/\z1/

" Dates:
" Year/01-12/01-31
syntax match txtDate "\d\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12]\d\|0\?[1-9]\|3[01]\)"
" 01-31/01-12/Year
syntax match txtDate "\%([12]\d\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\d\{1,4}"

" Special abbreviations: e.g., ie
syntax match txtAbbrev "\<\%(e\.\?g\.\?\|i\.\?e\.\?\)\>"

" Section delimiters
syntax match txtSectionDelimiter /^[[:space:]]*\([[:punct:]]\)\1*[[:space:]]*$/

highlight link txtTitle            Statement
highlight link txtLink             Underlined
highlight link txtEmail            Underlined
" highlight txtList term=bold cterm=bold gui=bold
highlight link txtList             Constant
highlight link txtNote             PreProc
highlight link txtAcronym          Type
highlight link txtNumber           Constant
highlight link txtBaseFileName     Comment
highlight link txtFile             Comment
highlight link txtDirectory        Comment
highlight link txtString           Constant
highlight link txtDate             Constant
highlight link txtAbbrev           Type
highlight link txtSectionDelimiter PreProc
