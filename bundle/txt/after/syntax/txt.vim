syntax match Label \%(^[[:space:]]*\n\|\%^\)\zs.*[^.?!]\ze\n^[[:space:]]*$
syntax match Underlined /\<http[^"']\{-}\ze\%([[:space:]]\|['"]\|$\)/
syntax match helpSectionDelim /^[[:space:]]*-\+[[:space:]]*$/
