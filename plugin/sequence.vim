" Increment / Decrement / Add / Subtract
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/sequence.vim
"
" Todo: repeat.vim

if exists('g:loaded_sequence')
    finish
endif
let g:loaded_sequence = 1

function! Sequence(mode, operation) range

    let firstline = a:firstline
    let lastline  = a:lastline

    let digit_pattern = '-\?\d\+'

    if 'n' == a:mode

        if getline(firstline) =~ digit_pattern && firstline == lastline

            while getline(firstline - 1) =~ digit_pattern && firstline > 1

                let firstline -= 1
            endwhile

            while getline(lastline + 1) =~ digit_pattern && lastline < line('$')

                let lastline += 1
            endwhile

            execute firstline
        endif

    elseif "\<c-v>" == visualmode()

        if col("'<") < col("'>")

            let col_start = col("'<")
            let col_end   = col("'>")
        else
            let col_start = col("'>")
            let col_end   = col("'<")
        endif

        if col_end >= col('$')

            let _digit =
                \'\%' . col_start . 'c.\{-}\zs' .
                \digit_pattern
        else
            let col_end += 1

            let _digit =
                \'\%' . col_start . 'c.\{-}\zs' .
                \digit_pattern .
                \'\ze.\{-}\%' . col_end . 'c'
        endif

    endif

    " subtraction or addition
    if a:operation =~ 'block'

        let counter = v:count1
    else
        let counter = 0
    endif

    " subtraction
    if 'block_x' == a:operation

        let operation = '-'
    else
        let operation = '+'
    endif

    for i in range(0, lastline - firstline)

        if 'v' == a:mode && "\<c-v>" == visualmode()

            let digit = matchstr(getline('.'), _digit)
        else
            let digit  = matchstr(getline('.'), digit_pattern)
            let _digit = digit
        endif

        if '' != digit

            execute 'silent substitute/' . _digit . '/' .
                \'\=' . digit . operation . 'counter/e'

            if 'seq_i' == a:operation

                let counter += v:count1

            elseif 'seq_d' == a:operation

                let counter -= v:count1
            endif
        endif
        +
    endfor

endfunction

vmap <m-a> :     call Sequence('v', 'seq_i')<cr>
vmap <m-x> :     call Sequence('v', 'seq_d')<cr>
nmap <m-a> :<c-u>call Sequence('n', 'seq_i')<cr>
nmap <m-x> :<c-u>call Sequence('n', 'seq_d')<cr>

vmap <c-a> :call Sequence('v', 'block_a')<cr>
vmap <c-x> :call Sequence('v', 'block_x')<cr>
