" Increment / Decrement / Add / Subtract
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/sequence.vim
"
" Todo: vb mode
" Todo: Calculate the range instead of giving one
" Todo: repeat.vim
" Todo: \<c-a> -> <c-A>? (same for \<c-x>

if exists('g:loaded_sequence')
    finish
endif
let g:loaded_sequence = 1

function! Sequence(operation) range

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

    for i in range(0, a:lastline - a:firstline)

        let digit = matchstr(getline('.'), '-\?\d\+')

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

vmap \<c-a> :call Sequence('seq_i')  <cr>
vmap \<c-x> :call Sequence('seq_d')  <cr>
vmap  <c-a> :call Sequence('block_a')<cr>
vmap  <c-x> :call Sequence('block_x')<cr>
