lmapclear <buffer>

source $HOME/.vim/keymap/bg.vim

setlocal spelllang=ru
let b:keymap_name = "ру"

inoreabbrev абв абвгдеёжзийклмнопрстуфхцчшщъыьэюя<cr>АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ

" U+0451 CYRILLIC SMALL   LETTER IO
" U+0401 CYRILLIC CAPITAL LETTER IO
lnoremap <buffer> :e  ё
lnoremap <buffer> :E  Ё
" U+044B CYRILLIC SMALL   LETTER YERU
" U+042B CYRILLIC CAPITAL LETTER YERU
" Note: I used [ for ь in the bulgarian keymap so [] feels appropriate
"       ~ is used to switch case
lnoremap <buffer> []  ы
lnoremap <buffer> ~[] Ы
" U+044D CYRILLIC SMALL   LETTER E
" U+042D CYRILLIC CAPITAL LETTER E
lnoremap <buffer> )e  э
lnoremap <buffer> )E  Э
