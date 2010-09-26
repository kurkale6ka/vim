" Increment / Decrement / Add / Subtract
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/sequence.vim
"
" Todo: vb mode
" Todo: repeat.vim

"if exists('g:loaded_sequence')
"finish
"endif
"let g:loaded_sequence = 1

function! Sequence(operation) range

    let firstline = a:firstline
    let lastline  = a:lastline

    let digit_pattern = '-\?\d\+'

    if getline(firstline) =~ digit_pattern && firstline == lastline

        while getline(firstline - 1) =~ digit_pattern && firstline > 1

            let firstline -= 1
        endwhile

        while getline(lastline + 1) =~ digit_pattern && lastline < line('$')

            let lastline += 1
        endwhile

        execute firstline
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

        let digit = matchstr(getline('.'), digit_pattern)

        if '' != digit

            execute 'silent substitute/' . digit . '/' .
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

vmap <m-a> :     call Sequence('seq_i')<cr>
vmap <m-x> :     call Sequence('seq_d')<cr>
nmap <m-a> :<c-u>call Sequence('seq_i')<cr>
nmap <m-x> :<c-u>call Sequence('seq_d')<cr>

vmap <c-a> :call Sequence('block_a')<cr>
vmap <c-x> :call Sequence('block_x')<cr>
