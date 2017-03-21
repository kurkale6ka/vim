if mapcheck('<Plug>(miniyank-autoput)', 'n') != ''

   " paste
   map p <Plug>(miniyank-autoput)
   map P <Plug>(miniyank-autoPut)

   " cycle backwards
   map <c-p> <Plug>(miniyank-cycle)
   map <c-n> g-

endif
