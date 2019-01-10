" List buffers
nmap <leader>b :Buffers<cr>

" Recently edited files
nmap <leader>r :History<cr>

" TODO: separate function, to emulate vf()
command! -nargs=+ VF call fzf#run(fzf#wrap({
   \ 'source': 'locate -0 / | grep -zv "/\.\(git\|svn\|hg\)\(/\|$\)\|~$"',
   \ 'options': '--read0 -0 -1 -m -q"'.<q-args>.'" --prompt "VF> "'
   \ }))
nmap <s-space> :VF<space>

" Set 'ft
nmap <leader>f :Filetypes<cr>