" List buffers
if exists(':Buffers')
   nmap <leader>b :Buffers<cr>
else
   nmap <leader>b :ls<cr>:b<space>
endif
