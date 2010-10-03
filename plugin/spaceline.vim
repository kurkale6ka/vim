" Spacing lines
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/spaceline.vim

function! s:SpaceLine(both)

    let save_cursor = getpos(".")

    let comment_pattern = '^[[:space:]]*\%(["*#;]\|\/\/\|\/\*\)'

    let line_above = getline(line('.') - 1)
    let line_below = getline(line('.') + 1)

    if line_above =~ '[^[:space:]]'

        if line_above !~ comment_pattern &&
            \ len(line_above) > 6        ||
            \ v:count1 > 1               ||
            \ !empty(a:both)

            normal O
            +
        endif
    endif

    if line_below =~ '[^[:space:]]'

        if len(line_below) > 6 || v:count1 > 1 || !empty(a:both)

            normal o
            -
        endif
    endif

    let virtualedit_bak = &virtualedit
    set virtualedit=

    if !empty(a:both)

        silent! call repeat#set("\<plug>SpacelineBoth")
    else
        silent! call repeat#set("\<plug>SpacelineSingle")
    endif

    let &virtualedit = virtualedit_bak

    call setpos('.', save_cursor)

endfunction

nmap <silent> <plug>SpacelineSingle :<c-u>call <sid>SpaceLine('')<cr>
nmap <silent> <plug>SpacelineBoth   :<c-u>call <sid>SpaceLine('both')<cr>

nmap <leader>o <plug>SpacelineSingle
nmap <leader>O <plug>SpacelineBoth
