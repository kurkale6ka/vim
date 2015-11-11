command! -nargs=+ Locate call fzf#run(fzf#vim#wrap({'source': 'locate -Ai -0 '.<q-args>.' | grep -z -vE "~$"', 'options': '--read0 -0 -1 -m --prompt "Locate> "'}))

nmap <s-space> :Locate<space>
