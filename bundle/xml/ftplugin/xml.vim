map <leader>< :substitute/>\zs[[:space:]]*\ze</\r/g<cr>
map <leader>> :substitute/>\zs[[:space:]]*\ze</\r/g<cr>

imap <silent> <buffer> <leader><leader> <!--  --><left><left><left><left>
imap <silent> <buffer> <leader>cs <!--<cr><cr>><left><up><space>

command! DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc
