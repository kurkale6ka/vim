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

        for i in range(a:firstline, a:lastline)

            execute i

            if 'V' ==# visualmode() ||
                \ 'v' ==# visualmode() && line("'<") != line("'>")

                let col_start = 1
                let col_end   = col('$')
            endif

            execute 'silent substitute/\%' . col_start . 'c[[:space:]]*\zs\(.\{-1,}\)\([[:space:]]*' .
                \operators .
                \'[[:space:]]*\)\(.\{-1,}\)\ze[[:space:]]*' .
                \'\%' . col_end . 'c/\3\2\1/e'
        endfor

    elseif 'nr' == a:mode

        "let word = 
        execute "substitute/\(\<c-r>\<c-a>\)\([[:space:]]\+\|\_[[:space:]]*\)\(\[^[:space:]]\+\)/\3\2\1/e"

    elseif 'nl' == a:mode

        execute "substitute/\(\[^[:space:]]\+\)\([[:space:]]\+\|\_[[:space:]]*\)\(\<c-r>\<c-a>\)/\3\2\1/e"
    endif

endfunction

vmap <leader>=         :     call Swap_comparison_operands('v')<cr>
vmap <leader><leader>= :     call Swap_comparison_operands('vi')<cr>
nmap <leader>=         :<c-u>call Swap_comparison_operands('nr')<cr>
nmap <leader>l=        :<c-u>call Swap_comparison_operands('nl')<cr>
