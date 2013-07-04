syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=[[:upper:]][^[:punct:]]*[^.?!:]\%(\n^[[:space:]]*$\)\@=/

syntax case match

" ACRONYM
syntax match txtAcronym /\%(\U.\{-}\H\)\@<=[[:upper:]]\{2,}\>\|\H\@<=[[:upper:]]\{2,}\>\%(.\{-}\U\)\@=/

" Numbers
syntax match txtNumber /[[:digit:]]\+/

" Lists:
" * | - | 1. | IV) | a)
" * | - | 2. | XI) | b)
syntax match txtList /^[[:space:]]*\%([*-]\|[[:digit:]]\+[[:space:]]*[.)]\?\|\%([[:alpha:]]\|[IVXLCDM]\+\)[[:space:]]*[.)]\)/

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

syntax region txtString start=/\z(["`]\|'\%([st]\>\)\@!\)/ skip=/\\\z1/ end=/\z1/
syntax region txtParens matchgroup=Constant start=/\[/ end=/\]/ transparent
syntax region txtParens matchgroup=Constant start=/{/  end=/}/  transparent
syntax region txtParens matchgroup=Constant start=/(/  end=/)/  transparent

syntax match txtTodo /@\?todo[[:space:]]*:\?/

" syntax keyword txtPLanguage c c++ perl python ruby php lisp

syntax case ignore

" scheme://username:password@domain:port/path?query_string#fragment_id
"                            protocol               user:pass          sub/domain .com, .co.uk         port       qs
"                     ======================------------------------=============================----------------===
syntax match txtLink "\<\%(https\?\|ftp\)://\%(\w\+\%(:\w\+\)\?@\)\?\a\%(-\|\w\)*\%(\.\w\{2,}\)\+\%(:\d\{1,5}\)\?\S*"

syntax match txtEmail "\%(mailto:\)\?[-[:alnum:]_#~+]\+\%(\.[-[:alnum:]_#~+]\+\)\?@[-[:alnum:]_#~+]\+\%(\.[-[:alnum:]_#~+]\+\)\+"

syntax keyword txtEditor vi[m] nvi [x]emacs textmate

syntax match txtVariable /\$\w\+/

" Dates:
" Year/01-12/01-31
syntax match txtDate "[[:digit:]]\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)"
" 01-31/01-12/Year
syntax match txtDate "\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1[[:digit:]]\{1,4}"
" Time: (03:24:44 Pm)
syntax match txtTime "\%(0\?[[:digit:]]\|1[[:digit:]]\|2[0-3]\)\%(:[0-5][[:digit:]]\)\{1,2}\%([[:space:]]*[ap]m\)\?"

" Special abbreviations: e.g., ie
syntax match txtAbbrev "\<\%(e\.\?g\.\?\|i\.\?e\.\?\)\A\@="

" Section delimiters
syntax match txtSectionDelimiter /^[[:space:]]*\([[:punct:]]\)\1*[[:space:]]*$/

" highlight txtList term=bold cterm=bold gui=bold
highlight link txtAbbrev           Type
highlight link txtAcronym          Type
highlight link txtBaseFileName     Special
highlight link txtDate             Constant
highlight link txtDirectory        Special
highlight link txtEditor           Identifier
highlight link txtEmail            Underlined
highlight link txtFile             Special
highlight link txtLink             Underlined
highlight link txtList             Constant
highlight link txtNote             PreProc
highlight link txtNumber           Constant
highlight link txtSectionDelimiter PreProc
highlight link txtString           Constant
highlight link txtTime             Constant
highlight link txtTitle            Statement
highlight link txtTodo             Todo
highlight link txtVariable         PreProc
