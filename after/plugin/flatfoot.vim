if !exists("g:loaded_flatfoot")
   finish
endif

if !exists("g:flatfoot_".char2nr("\<C-P>"))
   let flatfoot_{char2nr("\<C-P>")} = '[[:punct:]]'
endif
