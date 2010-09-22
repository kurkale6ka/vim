" Chosen rule: keep the left position unchanged
"
" There will be a shift of one character to the right for the cases:
" a ==b or a== b
"
" Note: \%V should restrict the operation to the visual area only!
"       :s actually operates from '< to EOL!
"       This is why I had to add the column matching (\% . col_end . c)
"
" Todo: rightleft + '.' + check if loaded

function! Swap_comparison_operands()

    let operators = '\(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)'

    "if 'V' == visualmode()

        "let col_start = col('^')
        "let col_end   = col('$') + 1

        "execute '*substitute/\([[:space:]]*\)\(.\{-1,}\)\([[:space:]]*\)' .
            "\operators .
            "\'\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*' .
            "\'/\=' .
            "\'Swap_operands(' .
            "\'strlen(submatch(1) . submatch(2) . submatch(4) . submatch(6)),' .
            "\'submatch(2),' .
            "\'submatch(3),' .
            "\'submatch(4),' .
            "\'submatch(5),' .
            "\'submatch(6),' .
            "\'col_start,'   .
            "\'col_end)'
    "else
        if col("'<") < col("'>")

            let col_start = col("'<")
            let col_end   = col("'>") + 1
        else
            let col_start = col("'>")
            let col_end   = col("'<") + 1
        endif

        execute '*substitute/\%V\([[:space:]]*\)\(.\{-1,}\)\([[:space:]]*\)' .
            \operators .
            \'\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*' .
            \'\%' . col_end . 'c/\=' .
            \'Swap_operands(' .
            \'strlen(submatch(1) . submatch(2) . submatch(4) . submatch(6)),' .
            \'submatch(2),' .
            \'submatch(3),' .
            \'submatch(4),' .
            \'submatch(5),' .
            \'submatch(6),' .
            \'col_start,'   .
            \'col_end)'
    "endif

endfunction

function! Swap_operands(left_length, l_ope, sp1, op, sp2, r_ope, col1, col2)

    let right_length = a:col2 - a:col1 - a:left_length

    " a==b
    " ->
    " b==a
    if a:sp1 !~ '[[:space:]]' && a:sp2 !~ '[[:space:]]'

        if right_length > 0

            let res  = printf('%' . a:left_length . 's%-' . right_length . 's',
                \a:r_ope . a:op . a:l_ope, ' ')
        else
            let res  = printf('%' . a:left_length . 's',
                \a:r_ope . a:op . a:l_ope)
        endif

        " a == b or a ==b or a== b
        " ->
        " b == a
    else
        let _left_length = a:left_length + 2
        let _right_length = right_length - 2

        if right_length > 2

            let res  = printf('%' . _left_length . 's%-' . _right_length . 's',
                \a:r_ope . ' ' . a:op . ' ' . a:l_ope, ' ')
        else
            let res  = printf('%' . _left_length . 's',
                \a:r_ope . ' ' . a:op . ' ' . a:l_ope)
        endif
    endif

    return res

endfunction

vmap <leader>= :<c-u>call Swap_comparison_operands()<cr>
