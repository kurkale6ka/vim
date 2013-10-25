" ACRONYMS {{{1
syntax match txtAcronym /\%([^-_A-Za-z0-9]\|^\)\zs\%(\u\|\d\)\+\ze\%([^-_A-Za-z0-9]\|$\)/
highlight link txtAcronym Type

" Lists and numbers {{{1
syntax match txtNumber /\d\+/
highlight link txtNumber Constant

" * | - | 1. | IV) | a)
" * | - | 2. | XI) | b)
syntax match txtList /^\s*\%([*-]\|\d\+\s*[.)]\?\|\%(\a\|[IVXLCDM]\+\)\s*[.)]\)/
highlight link txtList Constant

" Files {{{1
" Basename
syntax match txtBaseFileName "\%(\k\+\.[[:alpha:]]\+\|README\)\>"
highlight link txtBaseFileName Special
" Unix relative file path
" syntax match txtFile "\%(\%(\.\.\?\|\k\+\)/\)\+\k\+\%(\.[[:alpha:]]\+\)\?"
" Unix absolute file path
syntax match txtFile "\%(\s\|^\)\zs\~\?/\f\+"
" syntax match txtFile "\%(\~\|\.\.\?\)\?/\%(\%(\.\.\|\k\+\)/\)*\k\+\%(\.[[:alpha:]]\+\)\?\>"
" Unix directory
" syntax match txtDirectory "\%(\.\.\?\|\k\+\)/\>"
" highlight link txtDirectory Special
syntax match Normal "OS\%(/2\)\@="
" Windows absolute file path
syntax match txtFile "[[:alpha:]]:\\\%(\k\+\\\)\+\k\+\%(\.[[:alpha:]]\+\)\?\>"
highlight link txtFile Special

" Strings and parens {{{1
" Note: skips don't or girl's between ''s
syntax region txtString start=/\z(["`]\|'\%([st]\s\)\@!\)/ skip=/\\\z1/ end=/\z1/
highlight link txtString Constant

" Parens
syntax region txtParens matchgroup=Constant start=/\[/ end=/\]/ transparent
syntax region txtParens matchgroup=Constant start=/{/  end=/}/  transparent
syntax region txtParens matchgroup=Constant start=/(/  end=/)/  transparent

syntax case ignore

" Notes and TODOs {{{1
syntax match txtNote /\%(^\s*\n\|\%^\)\@<=\s*[^[:digit:]].*:\s*$/
syntax match txtNote /\%(note\|ex\%(ample\)\?\).\{-}:/
highlight link txtNote PreProc

syntax match txtTodo /@\?todo\s*:\?/
highlight link txtTodo Todo

" Titles and sections {{{1
syntax match txtH1Title /\%(^\s*\n\|\%^\)\@<=\u[^[:punct:]]*[^.?!:]\ze\%({{{\d\+\)\?\n\%(^\s*$\)\@=/
syntax match txtH1Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*=\{3,}\s*$\)\@=/
syntax match txtH2Title /\a.\{-}\ze\%({{{\d\+\)\?\n\%(^\s*-\{3,}\s*$\)\@=/
highlight link txtH1Title Statement
highlight link txtH2Title Statement

" Section delimiters ( --- or ,,, or ... )
syntax match txtSectionDelimiter /^\s*[[:punct:]]\{3,}\s*$/
highlight link txtSectionDelimiter PreProc

syntax case match

" URLs and emails {{{1
syntax match txtLink "\<\%(https\?\|ftp\)://\S\+"

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

syntax keyword txtEditor Vi[m] [X]Emacs
highlight link txtEditor Identifier

syntax match txtVariable /\$\w\+/
highlight link txtVariable PreProc

syntax match txtCode /\<\%(cd\|git\|c\?ssh\|wget\|vim\|su\s-\)\s\+\S\+/
syntax match txtCode /\<\%(cp\|scp\)\%(\s\+\S\+\)\{2}/
syntax match txtCode /curl.\{-}http\S\+/
syntax match txtCode :/etc/init.d/\S\+\s\S\+:
syntax match txtCode /puppet agent --test\%(\s--tags\s\S\+\)\?/
highlight link txtCode Identifier

syntax match txtComments /#.*$/
syntax match txtComments /\%({{{\|}}}\)\d\+/
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
