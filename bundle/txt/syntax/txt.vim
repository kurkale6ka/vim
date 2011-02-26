syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=[[:upper:]]\w*[^.?!:]\%(\n^[[:space:]]*$\)\@=/

syntax match txtLink "\<\%(https\?\|ftp\)://\%([-[:alnum:]_#~+/]\+\.\)*[-[:alnum:]_#~+/]\+\%(?[-[:alnum:][:xdigit:]_~+=&;]\+\)\?"

syntax match txtEmail "\%(mailto:\)\?[-[:alnum:]_#~+]\+\%(\.[-[:alnum:]_#~+]\+\)\?@[-[:alnum:]_#~+]\+\.[-[:alnum:]_#~+]\+"

" ACRONYM
syntax match txtAcronym /\%(\U.\{-}\H\)\@<=[[:upper:]]\{2,}\>\|\H\@<=[[:upper:]]\{2,}\>\%(.\{-}\U\)\@=/

" Numbers
syntax match txtNumber /[[:digit:]]\+/

" Lists:
" * | - | 1. | IV) | a)
" * | - | 2. | XI) | b)
syntax match txtList /^[[:space:]]*\%([*-]\|[[:digit:]]\+[[:space:]]*[.)]\?\|\%([[:lower:]]\|[IVXLCDM]\+\)[[:space:]]*[.)]\)/

" Note:
syntax match txtNote /\%(^[[:space:]]*\n\|\%^\)\@<=[[:space:]]*[^[:digit:]].*:[[:space:]]*$/

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
syntax region txtParens matchgroup=Comment start=/\[/ end=/\]/ transparent
syntax region txtParens matchgroup=Comment start=/{/  end=/}/  transparent
syntax region txtParens matchgroup=Comment start=/(/  end=/)/  transparent

" Dates:
" Year/01-12/01-31
syntax match txtDate "[[:digit:]]\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)"
" 01-31/01-12/Year
syntax match txtDate "\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1[[:digit:]]\{1,4}"

" Special abbreviations: e.g., ie
syntax match txtAbbrev "\<\%(e\.\?g\.\?\|i\.\?e\.\?\)\A\@="

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
highlight link txtBaseFileName     Special
highlight link txtFile             Special
highlight link txtDirectory        Special
highlight link txtString           Constant
highlight link txtDate             Constant
highlight link txtAbbrev           Type
highlight link txtSectionDelimiter PreProc
