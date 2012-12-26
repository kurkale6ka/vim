set runtimepath=
   \$HOME/config/vimfiles,
   \$VIM/vimfiles,
   \$VIMRUNTIME,
   \$VIM/vimfiles/after,
   \$HOME/config/vimfiles/after

set viewdir=$HOME/config/vimfiles/view

behave xterm

set exrc
set modeline
set modelines=3

set guifont=DejaVu_Sans_Mono:h13,
   \Nimbus_Mono_L:h13,
   \Andale_Mono:h13,
   \Liberation_Mono:h13,
   \Monospace:h13

set directory+=$LOCALAPPDATA\Temp " swap files
set backupdir+=$LOCALAPPDATA\Temp

nmap <leader>/ :substitute:\\:/:g<cr>
xmap <leader>/ :substitute:\%V\\:/:g<cr>
