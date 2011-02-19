syntax match txtTitle /\%(^[[:space:]]*\n\|\%^\)\@<=.*[^.?!]\%(\n^[[:space:]]*$\)\@=/
syntax match txtLink /\<http[^"']\{-}\ze\%([[:space:]]\|['"]\|$\)/
syntax match txtSectionDelimiter /^[[:space:]]*-\+[[:space:]]*$/
syntax match txtList /^[[:space:]]*\%([*-]\|\d\+\.\?\)[[:space:]]\+/
syntax match txtAcronym /\<\u\{2,}\>/

highlight link txtTitle Statement
highlight link txtLink Underlined
highlight link txtList Constant
highlight link txtAcronym Type
highlight link txtSectionDelimiter helpSectionDelim
