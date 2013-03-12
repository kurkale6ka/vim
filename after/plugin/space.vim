if !exists("g:space_loaded")
   finish
endif

" Issues with the Space plugin
" I need to redefine it here because I don't want the mapping space.vim imposes!
nnoremap <bs> "_X
xmap <tab> >
