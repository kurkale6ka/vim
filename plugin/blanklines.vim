function! BlankLines() range

    let operation = 'normal 0Dj'

    if a:firstline != a:lastline

        let endline = a:lastline - a:firstline + 1
    else
        let endline = v:count1
    endif

    for i in range(1, endline)

        execute operation
    endfor

    let virtualedit_bak = &virtualedit
    set virtualedit=

    silent! call repeat#set(":call BlankLines()\<cr>")

    let &virtualedit = virtualedit_bak

endfunction

nmap <silent> <leader>d :call BlankLines()<cr>
vmap <silent> <leader>d :call BlankLines()<cr>
