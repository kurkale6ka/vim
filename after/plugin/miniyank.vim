" if !exists("g:loaded_miniyank")
"    finish
" endif

" paste
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" cycle
map <c-n> <Plug>(miniyank-cycle)
