" todo: use a loop, remember changed buffers, define an Undo function acting on
"       those buffers
function! Bufdo(args)

    execute 'bufdo ' . a:args

endfunction

command! -nargs=+ Bufdo call Bufdo(<q-args>)
