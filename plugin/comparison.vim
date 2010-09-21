" \%V should restrict the operation to the visual area only!
" :s actually operates from '< to EOL!

function! Swap_comparison()

    if col("'<") < col("'>")

        let col_start = col("'<")
        let col_end   = col("'>")
    else
        let col_start = col("'>")
        let col_end   = col("'<")
    endif

    let operators = '\(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)'

    execute '*substitute/\%V\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*' .
        \operators .
        \'[[:space:]]*\(.\+\)[[:space:]]*' .
        \'\%' . col_end . 'c/\=' .
        \'Swap_operators(submatch(1), submatch(2), submatch(3), submatch(4), col_start, col_end)'

endfunction

function! Swap_operators(spaces, l, ops, r, c1, c2)

    let left_length  = strlen(a:spaces . a:l . a:ops . a:r) + 2
    let right_length = a:c2 - a:c1 - left_length

    let res  = printf('%' . left_length . 's%-' . right_length . 's', a:r . ' ' . a:ops . ' ' . a:l, ' ')

    return res

endfunction

vmap <leader>= :<c-u>call Swap_comparison()<cr>

" This should work!
" vmap <leader>= :substitute/\%V\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*\(===\<bar>!==\<bar><>\<bar>\%(=[=~]\<bar>![=~]\<bar>>=\<bar>>\<bar><=\<bar><\)[#?]\?\)[[:space:]]*\(.\+\)\([[:space:]]*\)/\1 \4 \3 \2 \5<cr>
