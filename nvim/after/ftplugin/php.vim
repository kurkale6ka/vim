" Comments: \cs
imap <silent> <buffer> <localleader>cs /**<cr><cr>/<left><up><space>

inoremap <silent> <buffer> <localleader>E <?php echo  ?><left><left><left>

" Macro for class aware omnicompletion
let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"

let php_folding    = 3
let php_large_file = 0

" [69 E] [43 +] [45 -] [118 v] [116 t]
let b:surround_69  = "<?php echo \r ?>"
let b:surround_43  = "<?php echo '\r' ?>"
let b:surround_45  = "<?php \r ?>"
let b:surround_118 = "var_dump(\r)"
let b:surround_116 = "try { \r } catch (Exception $e) {$e->getMessage();}"

set makeprg=php\ -l\ %\ $*
set errorformat=%E%m\ in\ %f\ on\ line\ %l,%Z%m
