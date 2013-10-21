" ACRONYMS {{{1
syntax match txtAcronym /\%(\U.\{-}\H\)\@<=[[:upper:]]\{2,}\>\|\H\@<=[[:upper:]]\{2,}\>\%(.\{-}\U\)\@=/
highlight link txtAcronym Type

" Lists and numbers {{{1
" * | - | 1. | IV) | a)
" * | - | 2. | XI) | b)
syntax match txtList /^[[:space:]]*\%([*-]\|[[:digit:]]\+[[:space:]]*[.)]\?\|\%([[:alpha:]]\|[IVXLCDM]\+\)[[:space:]]*[.)]\)/
highlight link txtList Constant

syntax match txtNumber /[[:digit:]]\+/
highlight link txtNumber Constant

" Titles and sections {{{1
syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=[[:upper:]][^[:punct:]]*[^.?!:]\%(\n^[[:space:]]*$\)\@=/
highlight link txtTitle Statement

" Section delimiters ( --------- or ,,,,,,,,,, or ... )
syntax match txtSectionDelimiter /^[[:space:]]*\([[:punct:]]\)\1\+[[:space:]]*$/
highlight link txtSectionDelimiter PreProc

syntax case match

" Files {{{1
" Basename
syntax match txtBaseFileName "\%(\k\+\.[[:alpha:]]\+\|README\)\>"
highlight link txtBaseFileName Special
" Unix relative file path
" syntax match txtFile "\%(\%(\.\.\?\|\k\+\)/\)\+\k\+\%(\.[[:alpha:]]\+\)\?"
" Unix absolute file path
syntax match txtFile "\%(\~\|\.\.\?\)\?/\%(\%(\.\.\|\k\+\)/\)*\k\+\%(\.[[:alpha:]]\+\)\?\>"
" Unix directory
" syntax match txtDirectory "\%(\.\.\?\|\k\+\)/\>"
highlight link txtDirectory Special
syntax match Normal "OS\%(/2\)\@="
" Windows absolute file path
syntax match txtFile "[[:alpha:]]:\\\%(\k\+\\\)\+\k\+\%(\.[[:alpha:]]\+\)\?\>"
highlight link txtFile Special

" Quotes and parens {{{1
syntax region txtString start=/\z(["`]\|'\%([st]\>\)\@!\)/ skip=/\\\z1/ end=/\z1/
highlight link txtString Constant

" Parens
syntax region txtParens matchgroup=Constant start=/\[/ end=/\]/ transparent
syntax region txtParens matchgroup=Constant start=/{/  end=/}/  transparent
syntax region txtParens matchgroup=Constant start=/(/  end=/)/  transparent

syntax case ignore

" Notes and TODOs {{{1
syntax match txtNote /\%(^[[:space:]]*\n\|\%^\)\@<=[[:space:]]*[^[:digit:]].*:[[:space:]]*$/
highlight link txtNote PreProc

syntax match txtTodo /@\?todo[[:space:]]*:\?/
highlight link txtTodo Todo

" URLs and emails {{{1
" scheme://username:password@domain:port/path?query_string#fragment_id
"                            protocol               user:pass          sub/domain .com, .co.uk         port       qs
"                     ======================------------------------=============================----------------===
syntax match txtLink "\<\%(https\?\|ftp\)://\%(\w\+\%(:\w\+\)\?@\)\?\a\%(-\|\w\)*\%(\.\w\{2,}\)\+\%(:\d\{1,5}\)\?\S*"
highlight link txtLink Underlined

"                                             user      @          domain
"                                      =================-===========================
syntax match txtEmail "\<\%(mailto:\)\?[-_.%[:alnum:]]\+@[-.[:alnum:]]\+\.\a\{2,4}\>"
highlight link txtEmail Underlined

" Programming {{{1
" syntax keyword txtPLanguage sh bash c c++ perl python ruby php lisp haskell

syntax keyword txtEditor vi[m] [x]emacs
highlight link txtEditor Identifier

syntax match txtVariable /\$\w\+/
highlight link txtVariable PreProc

syntax match txtComments /#.*$/
highlight link txtComments Comment

" Date and Time {{{1
" Year/01-12/01-31
syntax match txtDate "[[:digit:]]\{1,4}\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)"
" 01-31/01-12/Year
syntax match txtDate "\%([12][[:digit:]]\|0\?[1-9]\|3[01]\)\([-/.]\)\%(0\?[1-9]\|1[0-2]\)\1[[:digit:]]\{1,4}"
highlight link txtDate Constant

" Time: (03:24:44 Pm)
syntax match txtTime "\%(0\?[[:digit:]]\|1[[:digit:]]\|2[0-3]\)\%(:[0-5][[:digit:]]\)\{1,2}\%([[:space:]]*[ap]m\)\?"
highlight link txtTime Constant

" Special abbreviations: e.g., ie {{{1
syntax match txtAbbrev "\<\%(e\.\?g\.\?\|i\.\?e\.\?\)\A\@="
highlight link txtAbbrev Type
