AddTabularPipeline! words /\S\+/ tabular#TabularizeStrings(a:lines, '\S\+', 'r1l0')

AddTabularPipeline! css   /:/ tabular#TabularizeStrings(a:lines, ':\ze[^:]*$', 'l1')
            \ | tabular#TabularizeStrings(a:lines, ';', 'l1')

AddTabularPipeline! html  /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>'  , 'l1')
            \ | tabular#TabularizeStrings(a:lines, '<\/[A-Za-z:]\+>\%(.\{-}<\/[A-Za-z:]\+>\)\@!', 'l1')

" AddTabularPipeline! html  /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>'  , 'l1')
"             \ | tabular#TabularizeStrings(a:lines, '<\/\a\+>\%(.\{-}<\/\a\+>\)\@!', 'l1')

" 1   2    3        3    2    1
" <b> <i> <h1>  </h1> </i> </b>

" 1. Outer
" AddTabularPattern!  html  /\%(<[^<>?!/]*>.\{-}\)\@<!<[^<>?!/]*>/l1
" AddTabularPattern!  html  /<\/\a\+>\%(.\{-}<\/\a\+>\)\@!/l1

" 2. Outer - 1
" AddTabularPattern!  html  /\%(<[^<>?!/]*>.\{-}\)\@<!<[^<>?!/]*>.\{-}\zs<[^<>?!/]*>/l1
" AddTabularPattern!  html  /<\/\a\+>\ze[^<]*<\/\a\+>\%(.\{-}<\/\a\+>\)\@!/l1

" 3. Outer - 2
" AddTabularPattern!  html  /\%(<[^<>?!/]*>.\{-}\)\@<!\%(<[^<>?!/]*>.\{-}\)\{2}\zs<[^<>?!/]*>/l1
" AddTabularPattern!  html  /<\/\a\+>\ze\%([^<]*<\/\a\+>\)\{2}\%(.\{-}<\/\a\+>\)\@!/l1

" ... replace 2 by 3 and so on

"AddTabularPipeline! html /\%(<[^<>?!/]*>.\{-}\)\@<!<[^<>?!/]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!/]*>.\{-}\)\@<!<[^<>?!/]*>'  , 'l1')
"\ | tabular#TabularizeStrings(a:lines, '<\/\a\+>\%(.\{-}<\/\a\+>\)\@!', 'l1')
"\ | tabular#TabularizeStrings(a:lines, '\%(<[^<>?!/]*>.\{-}\)\@<!<[^<>?!/]*>.\{-}\zs<[^<>?!/]*>', 'l1')
"\ | tabular#TabularizeStrings(a:lines, '<\/\a\+>\ze[^<]*<\/\a\+>\%(.\{-}<\/\a\+>\)\@!', 'l1')
"\ | tabular#TabularizeStrings(a:lines, '\%(<[^<>?!/]*>.\{-}\)\@<!\%(<[^<>?!/]*>.\{-}\)\{2}\zs<[^<>?!/]*>', 'l1')
"\ | tabular#TabularizeStrings(a:lines, '<\/\a\+>\ze\%([^<]*<\/\a\+>\)\{2}\%(.\{-}<\/\a\+>\)\@!', 'l1')
