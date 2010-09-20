" \%V should restrict the operation to the visual area only!
" :s actually operates from '< to EOL!

function! Swap_comparison()

    if col("'<") < col("'>")

        let col_end = col("'>")
    else
        let col_end = col("'<")
    endif

    execute '*substitute/\%V\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*\(===\|!==\|<>\|\%(=[=~]\|![=~]\|>=\|>\|<=\|<\)[#?]\?\)[[:space:]]*\(.\+\)\([[:space:]]*\)\%' . col_end . 'c/\1 \4 \3 \2 \5'

endfunction

vmap <leader>= :<c-u>call Swap_comparison()<cr>

" This should work!
" vmap <leader>= :substitute/\%V\([[:space:]]*\)\(.\{-1,}\)[[:space:]]*\(===\<bar>!==\<bar><>\<bar>\%(=[=~]\<bar>![=~]\<bar>>=\<bar>>\<bar><=\<bar><\)[#?]\?\)[[:space:]]*\(.\+\)\([[:space:]]*\)/\1 \4 \3 \2 \5<cr>
