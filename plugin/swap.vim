" Chosen rule: keep the left position unchanged
"
" Todo: rightleft
" Todo: repeat.vim
" Todo: add the possibility to define custom 'operators'
" Todo: re-position the cursor using cursor()

if exists('g:loaded_swap')
    finish
endif
let g:loaded_swap = 1

function! Swap_comparison_operands(mode) range

    if a:mode =~ 'v'

        " visual interactive :)
        if 'vi' == a:mode

            let operators = input('Pivot: ')
            let operators = '\%(' . operators . '\)'
        else
            let operators = '\%(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)'
        endif

        if col("'<") < col("'>")

            let col_start = col("'<")
            let col_end   = col("'>") + 1
        else
            let col_start = col("'>")
            let col_end   = col("'<") + 1
        endif

        if 'V' ==# visualmode() ||
            \ 'v' ==# visualmode() && line("'<") != line("'>")

            execute 'silent ' . a:firstline . ',' . a:lastline . 'substitute/^[[:space:]]*\zs\(.\{-1,}\)\([[:space:]]*' .
                \operators .
                \'[[:space:]]*\)\(.\{-1,}\)\ze[[:space:]]*$/\3\2\1/e'
        endif

        execute 'silent ' . a:firstline . ',' . a:lastline . 'substitute/\%' . col_start . 'c[[:space:]]*\zs\(.\{-1,}\)\([[:space:]]*' .
            \operators .
            \'[[:space:]]*\)\(.\{-1,}\)\ze[[:space:]]*' .
            \'\%' . col_end . 'c/\3\2\1/e'

        let col_end_bak = col_end - 1

        execute 'normal ' . col_end_bak . '|'

    elseif a:mode =~ 'n'

        let col_start_bak = col('.')

        if 'nl' == a:mode

            call search('[^[:space:]]\+\%([[:space:]]\+\|\_[[:space:]]\+\)[^[:space:]]*\%' . col('.') . 'c', 'b')
        else
            let line_bak = line('.')
        endif

        execute 'substitute/\([^[:space:]]*\%' . col('.') . 'c[^[:space:]]*\)\([[:space:]]\+\|\_[[:space:]]*\)\([^[:space:]]\+\)/\3\2\1/e'

        if 'nr' == a:mode

            execute line_bak
        endif

        execute 'normal ' . col_start_bak . '|'

    endif

endfunction

vmap <leader>x         :call Swap_comparison_operands('v')<cr>
vmap <leader><leader>x :call Swap_comparison_operands('vi')<cr>
nmap <leader>x         :<c-u>call Swap_comparison_operands('nr')<cr>
nmap <leader><left>x   :<c-u>call Swap_comparison_operands('nl')<cr>
