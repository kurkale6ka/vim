command! -nargs=+ Locate call fzf#run({'source': 'locate -Ai -0 '.<q-args>.' | grep -z -vE "~$"', 'sink': 'e', 'options': '--read0 -0 -1 -m --prompt "Locate> "'})

nmap <s-space> :Locate<space>
