function! BlankLines() range

    let operation = 'normal 0Dj'

    if a:firstline == a:lastline

        for i in range(1, v:count1)

            execute operation
        endfor
    else
        for i in range(0, a:lastline - a:firstline)

            execute operation
        endfor
    endif

endfunction

nmap <silent> <leader>d :call BlankLines()<cr>
vmap <silent> <leader>d :call BlankLines()<cr>
