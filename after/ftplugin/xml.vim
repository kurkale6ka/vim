" Comments: \\ and \cs
imap <silent> <buffer> <localleader><localleader> <!--  --><left><left><left><left>
imap <silent> <buffer> <localleader>cs            <!--<cr><cr>><left><up><space>

command! -buffer -range=% -nargs=* Tidy <line1>,<line2>! xmllint --format --recover - 2>/dev/null
command! -buffer DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc
