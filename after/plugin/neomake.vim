if has('autocmd') && exists('g:loaded_neomake')
   autocmd! BufWritePost * Neomake
endif
