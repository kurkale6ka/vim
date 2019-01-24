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

" Keymaps
function! s:set_keymap(keymap)
   let &l:keymap = a:keymap
endfunction

command! -nargs=? Lang call fzf#run(fzf#wrap({
   \ 'source': map(split(globpath(&rtp, 'keymap/*.vim')),
   \              'fnamemodify(v:val, ":t:r")'),
   \ 'sink': function('s:set_keymap'),
   \ 'options': '-1 +m -q "'.<q-args>.'" --prompt "Keymap> "'
   \ }))
nmap <leader>l :Lang<cr>

" Set 'ft
nmap <leader>f :Filetypes<cr>
