lmapclear <buffer>

source $VIMRUNTIME/keymap/accents.vim

setlocal spelllang=fr
let b:keymap_name = "fr"

" U+00EB LATIN SMALL   LETTER E WITH DIAERESIS
" U+00CB LATIN CAPITAL LETTER E WITH DIAERESIS
lnoremap <buffer> :e ë
lnoremap <buffer> :E Ë
" U+00EF LATIN SMALL   LETTER I WITH DIAERESIS
" U+00CF LATIN CAPITAL LETTER I WITH DIAERESIS
lnoremap <buffer> :i ï
lnoremap <buffer> :I Ï
" U+00FF LATIN SMALL   LETTER Y WITH DIAERESIS
" U+0178 LATIN CAPITAL LETTER Y WITH DIAERESIS
lnoremap <buffer> :y ÿ
lnoremap <buffer> :Y Ÿ
