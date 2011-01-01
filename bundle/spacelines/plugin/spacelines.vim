" Spacing lines
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/spaceline.vim

function! s:SpaceLines(force)

    let save_cursor = getpos(".")

    let comment_pattern = '^[[:space:]]*\%(["*#;%]\|\/\/\|\/\*\)'

    let line_above = getline(line('.') - 1)
    let line_below = getline(line('.') + 1)

    let line_above_length = strlen(strpart(line_above, match(line_above, '\S')))
    let line_below_length = strlen(strpart(line_below, match(line_below, '\S')))

    let limit = 6

    if line_above =~ '[^[:space:]]'

        if line_above !~ comment_pattern &&
            \ line_above_length > limit  ||
            \ v:count1 > 1               ||
            \ !empty(a:force)

            normal O
            +
        endif
    endif

    if line_below =~ '[^[:space:]]'

        if line_below_length > limit || v:count1 > 1 || !empty(a:force)

            normal o
            -
        endif
    endif

    let virtualedit_bak = &virtualedit
    set virtualedit=

    if !empty(a:force)

        silent! call repeat#set("\<plug>SpaceLinesForce")
    else
        silent! call repeat#set("\<plug>SpaceLines")
    endif

    let &virtualedit = virtualedit_bak

    call setpos('.', save_cursor)

endfunction

nmap <silent> <plug>SpaceLines      :<c-u>call <sid>SpaceLines('')<cr>
nmap <silent> <plug>ForceSpaceLines :<c-u>call <sid>SpaceLines('force')<cr>

nmap <leader>m <plug>SpaceLines
nmap <c-cr>    <plug>SpaceLines
" Todo: count <c-cr>
nmap <leader>M <plug>ForceSpaceLines
