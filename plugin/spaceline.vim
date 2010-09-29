" Spacing lines
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/spaceline.vim

if exists('g:loaded_spaceline')
    finish
endif
let g:loaded_spaceline = 1

function! SpaceLine(both)

    let save_cursor = getpos(".")

    let comment_pattern = '^[[:space:]]*\%(["*#;]\|\/\/\|\/\*\)'

    let line_above = getline(line('.') - 1)
    let line_below = getline(line('.') + 1)

    if line_above =~ '[^[:space:]]'

        if line_above !~ comment_pattern && len(line_above) > 6 || v:count1 > 1 || !empty(a:both)

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

    call setpos('.', save_cursor)

endfunction

nmap <leader>o :<c-u>call SpaceLine('')<cr>
nmap <leader>O :<c-u>call SpaceLine('both')<cr>
