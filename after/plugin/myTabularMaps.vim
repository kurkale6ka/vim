AddTabularPipeline! alias /\s.*=/ tabular#TabularizeStrings(a:lines, '\s.*=', 'l0r0l0')

AddTabularPipeline! arrow /=>/ tabular#TabularizeStrings(a:lines, '=>', 'l1')

AddTabularPipeline! css /:/ tabular#TabularizeStrings(a:lines, '{\%(\s*$\)\@!\|\%(^\s*\|;\s*\)\@<!}\|:\|;', 'l1')
" AddTabularPipeline! css /:/ tabular#TabularizeStrings(a:lines, 'Ta/{\%(\s*$\)\@!\|\%(^\s*\|;\s*\)\@<!}\|:\%(\_[^{]\{-}}\)\@=\|;', 'l1')
"             \ | tabular#TabularizeStrings(a:lines, ';', 'l1')

AddTabularPipeline! html /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>', 'l1')
            \ | tabular#TabularizeStrings(a:lines, '<\/[A-Za-z:]\+>\%(.\{-}<\/[A-Za-z:]\+>\)\@!', 'l1')

" AddTabularPipeline! html /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>', 'l1')
"             \ | tabular#TabularizeStrings(a:lines, '<\/\a\+>\%(.\{-}<\/\a\+>\)\@!', 'l1')

AddTabularPipeline! words /\S\+/ tabular#TabularizeStrings(a:lines, '\S\+', 'r1l0')
