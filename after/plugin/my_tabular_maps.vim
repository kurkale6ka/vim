if !exists(':Tabularize')
    finish " Give up here; the Tabular plugin musn't have been loaded
endif

" Make line wrapping possible by resetting the 'cpo' option, first saving it
let s:save_cpo = &cpo
set cpo&vim

AddTabularPipeline! alias /\S\+=/ tabular#TabularizeStrings(a:lines, '\S\+=', 'l1r0l0')

AddTabularPipeline! arrow /[=-]>/ tabular#TabularizeStrings(a:lines, '[=-]>', 'l1')

AddTabularPipeline! css /:/ tabular#TabularizeStrings(a:lines, '{\%(\s*$\)\@!\|\%(^\s*\|;\s*\)\@<!}\|:\|;', 'l1')
" AddTabularPipeline! css /:/ tabular#TabularizeStrings(a:lines, 'Ta/{\%(\s*$\)\@!\|\%(^\s*\|;\s*\)\@<!}\|:\%(\_[^{]\{-}}\)\@=\|;', 'l1')
"             \ | tabular#TabularizeStrings(a:lines, ';', 'l1')

AddTabularPipeline! html /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>', 'l1')
            \ | tabular#TabularizeStrings(a:lines, '<\/[A-Za-z:]\+>\%(.\{-}<\/[A-Za-z:]\+>\)\@!', 'l1')

" AddTabularPipeline! html /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>', 'l1')
"             \ | tabular#TabularizeStrings(a:lines, '<\/\a\+>\%(.\{-}<\/\a\+>\)\@!', 'l1')

AddTabularPipeline! words /\S\+/ tabular#TabularizeStrings(a:lines, '\S\+', 'r1l0')

" Restore the saved value of 'cpo'
let &cpo = s:save_cpo
unlet s:save_cpo
