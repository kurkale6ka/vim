behave xterm

set guifont=DejaVu_Sans_Mono:h13,
   \Nimbus_Mono_L:h13,
   \Andale_Mono:h13,
   \Liberation_Mono:h13,
   \Monospace:h13

set directory+=$LOCALAPPDATA\Temp " swap files
set backupdir+=$LOCALAPPDATA\Temp

nmap <leader>/ :s:\\:/:g<cr>
xmap <leader>/ :s:\%V\\:/:g<cr>
