" Chosen rule: keep the left position unchanged
"
" There will be a shift of one character to the right for the cases:
" a ==b or a== b
"
" Todo: rightleft
" Todo: repeat.vim
" Todo: add the possibility to define custom 'operators'
" Todo: Change [&& 'V' !=# visualmode()] to something better (see line 47)

if exists('g:loaded_swap')
    finish
endif
let g:loaded_swap = 1

function! Swap_comparison_operands(mode) range

    if a:mode =~ 'v'

        " visual interactive :)
        if 'vi' == a:mode

            let operators = input('Pivot: ')
            let operators = '\(' . operators . '\)'
        else
            let operators = '\(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)'
        endif

        if col("'<") < col("'>")

            let col_start = col("'<")
            let col_end   = col("'>") + 1
        else
            let col_start = col("'>")
            let col_end   = col("'<") + 1
        endif

        for i in range(a:firstline, a:lastline)

            execute i

            if 'V' ==# visualmode() ||
                \ 'v' ==# visualmode() && line("'<") != line("'>")

                let col_start = 1
                let col_end   = col('$')
            endif

            execute 'silent substitute/\%' . col_start . 'c\([[:space:]]*\)\(.\{-1,}\)\([[:space:]]*\)' .
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
                \col_start. ',' .
                \col_end  . ')/e'
        endfor

    elseif 'nr' == a:mode

        normal daWWP

    elseif 'nl' == a:mode

        normal daWBP
    endif

endfunction

function! Swap_operands(left_length, l_ope, sp1, op, sp2, r_ope, col1, col2)

    let right_length = a:col2 - a:col1 - a:left_length

    " a==b
    " ->
    " b==a
    if a:sp1 !~ '[[:space:]]' && a:sp2 !~ '[[:space:]]'

        if right_length > 0 && 'V' !=# visualmode()

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

        if right_length > 2 && 'V' !=# visualmode()

            let res  = printf('%' . _left_length . 's%-' . _right_length . 's',
                \a:r_ope . ' ' . a:op . ' ' . a:l_ope, ' ')
        else
            let res  = printf('%' . _left_length . 's',
                \a:r_ope . ' ' . a:op . ' ' . a:l_ope)
        endif
    endif

    return res

endfunction

vmap <leader>=         :     call Swap_comparison_operands('v')<cr>
vmap <leader><leader>= :     call Swap_comparison_operands('vi')<cr>
nmap <leader>=         :<c-u>call Swap_comparison_operands('nr')<cr>
nmap <leader>l=        :<c-u>call Swap_comparison_operands('nl')<cr>
