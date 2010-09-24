" Easy swapping of text
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/swap.vim
"
" Todo: rightleft
" Todo: repeat.vim
" Todo: add the possibility to define custom 'operators'
" Todo: re-position the cursor using cursor()
"       Position of cursor in the visual area?

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
            let operators =
                \'\%(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)'
        endif

        " Whole lines
        if 'V' ==# visualmode() ||
            \ 'v' ==# visualmode() && line("'<") != line("'>")

            execute 'silent ' . a:firstline . ',' . a:lastline .
                \'substitute/^[[:space:]]*\zs' .
                \'\([^[:space:]].\{-}\)' .
                \'\([[:space:]]*' . operators . '[[:space:]]*\)' .
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
                \'\([[:space:]]*' . operators . '[[:space:]]*\)' .
                \'\([^[:space:]].\{-}\)' .
                \'\ze[[:space:]]*\%' . col_end . 'c/\3\2\1/e'
        endif

        normal `>

    elseif a:mode =~ 'n'

        let col_bak  = col('.')
        let line_bak = line('.')

        if 'nl' == a:mode

            call search('[^[:space:]]\+' .
                \'\%([[:space:]]\+\|\_[[:space:]]\+\)' .
                \'[^[:space:]]*\%' . col('.') . 'c', 'b')
        endif

        execute 'substitute/\([^[:space:]]*\%' . col('.') . 'c[^[:space:]]*\)' .
            \'\([[:space:]]\+\|\_[[:space:]]*\)' .
            \'\([^[:space:]]\+\)/\3\2\1/e'

        call cursor(line_bak, col_bak)

    endif

endfunction

vmap <leader>x         :call Swap_comparison_operands('v')<cr>
vmap <leader><leader>x :call Swap_comparison_operands('vi')<cr>
nmap <leader>x         :<c-u>call Swap_comparison_operands('nr')<cr>
nmap <leader><left>x   :<c-u>call Swap_comparison_operands('nl')<cr>
