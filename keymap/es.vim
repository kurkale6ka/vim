lmapclear <buffer>

source $VIMRUNTIME/keymap/accents.vim

setlocal spelllang=es
let b:keymap_name = "es"

" U+00BF INVERTED QUESTION    MARK
" U+00A1 INVERTED EXCLAMATION MARK
lnoremap <buffer> '? ¿
lnoremap <buffer> '! ¡
