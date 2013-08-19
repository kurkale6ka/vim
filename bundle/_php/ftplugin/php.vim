set makeprg=php\ -l\ %\ $*
set errorformat=%E%m\ in\ %f\ on\ line\ %l,%Z%m

" Useful for class aware omnicompletion
let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"

let php_folding = 3
let php_large_file = 0

inoremap <silent> <buffer> <leader>E <?php echo  ?><left><left><left>
imap     <silent> <buffer> <leader>cs /**<cr><cr>/<left><up><space>
