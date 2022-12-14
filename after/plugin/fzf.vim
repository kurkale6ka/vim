" List files
nmap <leader>f :Files<cr>

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
command! -nargs=? Lang call fzf#run(fzf#wrap({
   \ 'source': map(split(globpath(&rtp, 'keymap/*.vim')),
   \              'fnamemodify(v:val, ":t:r")'),
   \ 'sink': {keymap -> execute('setlocal keymap='.keymap)},
   \ 'options': '-1 +m -q "'.<q-args>.'" --prompt "Keymap> "'
   \ }))
nmap <leader>l :Lang<cr>

" Scriptnames
command! -nargs=? Scriptnames call fzf#run(fzf#wrap({
   \ 'source': split(execute('scriptnames'), '\n'),
   \ 'sink': {script -> execute('edit'.substitute(script, '^\s*\d\+:\s\+', '', ''))},
   \ 'options': '-1 +m -q "'.<q-args>.'" --prompt "Scriptnames> "'
   \ }))

" Set 'ft
nmap <leader>t :Filetypes<cr>

nmap <leader>G    :BLines <c-r><c-a>
xmap <leader>G "*y:BLines <c-r>*<cr>

" Custom help files
if !empty($REPOS_BASE)
   nmap <expr> <leader>h ':Files '.$REPOS_BASE.'/help<cr>'
endif

command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case --hidden -- '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)
