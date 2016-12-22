if mapcheck('<Plug>(miniyank-autoput)', 'n') != ''

   " paste
   map p <Plug>(miniyank-autoput)
   map P <Plug>(miniyank-autoPut)

   " cycle
   map <c-n> <Plug>(miniyank-cycle)

endif
