" \%V should restrict the operation to the visual area only!
" :s actually operates from '< to EOL!
"
" This is why I had to add the column matching (\% . col_end . c)

function! Swap_comparison_operands()

    if col("'<") < col("'>")

        let col_start = col("'<")
        let col_end   = col("'>") + 1
    else
        let col_start = col("'>")
        let col_end   = col("'<") + 1
    endif

    let operators = '\(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)'

    execute '*substitute/\%V\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*' .
        \operators .
        \'[[:space:]]*\(.\{-1,}\)[[:space:]]*' .
        \'\%' . col_end . 'c/\=' .
        \'Swap_operands(' .
        \'strlen(submatch(1) . submatch(2) . submatch(3) . submatch(4)) + 2,' .
        \'submatch(2), submatch(3), submatch(4), col_start, col_end)'

endfunction

function! Swap_operands(left_length, l_operand, op, r_operand, col1, col2)

    let right_length = a:col2 - a:col1 - a:left_length

    let res  = printf('%' . a:left_length . 's%-' . right_length . 's',
        \a:r_operand . ' ' . a:op . ' ' . a:l_operand, ' ')

    return res

endfunction

vmap <leader>= :<c-u>call Swap_comparison_operands()<cr>
