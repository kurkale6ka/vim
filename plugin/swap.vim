" Easy swapping of text
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/swap.vim
"
" Todo: rightleft
" Todo: repeat.vim
" Todo: re-position the cursor using cursor()
"       Position of cursor in the visual area?

if exists('g:loaded_swap')
    finish
endif
let g:loaded_swap = 1

let s:savecpo = &cpo
set cpo&vim

function! Swap_operands(mode) range

    if a:mode =~ 'v'

        let save_cursor = getpos("'>")

        " visual interactive :)
        if 'vi' == a:mode

            let operators = input('Pivot: ')
        else
            let logical_ops    = ['&&', '||']
            let assignment_ops = ['+=', '-=', '*=', '/=', '%=', '&=', '|=',
                \'^=', '<<=', '>>=']

            let bitwise_ops    = ['<<', '>>']
            let pointer_ops    = ['->*', '->']
            let scope_ops      = ['::']
            let comparison_ops = ['===', '!==', '<>', '==#', '!=#', '>#', '>=#',
                \'<#', '<=#', '=~#', '!~#', '==?', '!=?', '>?', '>=?', '<?',
                \'<=?', '=~?', '!~?', '==', '!=', '>=', '<=', '=~', '!~']

            let misc_ops       = ['>', '<', '=', '+', '-', '*', '/', '%', '&',
                \'|', '^', '.*', '.', '?', ':', ',', '~=', "'=", "'<", "'>",
                \'!<', '!>']

            let operators_list = logical_ops + assignment_ops + bitwise_ops +
                \pointer_ops + scope_ops + comparison_ops + misc_ops

            if exists('g:swap_custom_ops')

                " let g:swap_custom_ops = ['first_operator', 'second_operator']
                let operators_list += g:swap_custom_ops
            endif

            let operators = join(operators_list, '\|')
            let operators = escape(operators, '*/~.^')
        endif

        " Whole lines
        if 'V' ==# visualmode() ||
            \ 'v' ==# visualmode() && line("'<") != line("'>")

            execute 'silent ' . a:firstline . ',' . a:lastline .
                \'substitute/^[[:space:]]*\zs' .
                \'\([^[:space:]].\{-}\)' .
                \'\([[:space:]]*\%(' . operators . '\)[[:space:]]*\)' .
                \'\([^[:space:]].\{-}\)' .
                \'\ze[[:space:]]*$/\3\2\1/e'
        else
            if col("'<") < col("'>")

                let col_start = col("'<")
                let col_end   = col("'>") + 1
            else
                let col_start = col("'>")
                let col_end   = col("'<") + 1
            endif

            execute 'silent ' . a:firstline . ',' . a:lastline .
                \'substitute/\%' . col_start . 'c[[:space:]]*\zs' .
                \'\([^[:space:]].\{-}\)' .
                \'\([[:space:]]*\%(' . operators . '\)[[:space:]]*\)' .
                \'\([^[:space:]].\{-}\)' .
                \'\ze[[:space:]]*\%' . col_end . 'c/\3\2\1/e'
        endif

        " Swap Words
    elseif a:mode =~ 'n'

        let save_cursor = getpos(".")

        " swap with Word on the left
        if 'nl' == a:mode

            call search('[^[:space:]]\+' .
                \'\%([[:space:]]\+\|\_[[:space:]]\+\)' .
                \'[^[:space:]]*\%' . col('.') . 'c', 'bW')
        endif

        " swap with Word on the right
        execute 'substitute/\([^[:space:]]*\%' . col('.') . 'c[^[:space:]]*\)' .
            \'\([[:space:]]\+\|\_[[:space:]]\+\)' .
            \'\([^[:space:]]\+\)/\3\2\1/e'
    endif

    call setpos('.', save_cursor)

endfunction

vmap <leader>x         :call Swap_operands('v')<cr>
vmap <leader><leader>x :call Swap_operands('vi')<cr>
nmap <leader>x         :<c-u>call Swap_operands('nr')<cr>
nmap <leader>X         :<c-u>call Swap_operands('nl')<cr>

let &cpo = s:savecpo
unlet s:savecpo
