" LaTeX
"
" Author: Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/plugin/latex.vim

if exists('g:loaded_latex') || &compatible || v:version < 700

    if &compatible && &verbose

        echo "LaTeX is not designed to work in compatible mode."

    elseif v:version < 700

        echo "LaTeX needs Vim 7.0 or above to work correctly."
    endif

    finish
endif

let g:loaded_latex = 1

let s:savecpo = &cpoptions
set cpoptions&vim

function! s:Document()

    let doc  = '\documentclass[12pt,a4paper]{article}' . "\n"
    let doc .=                                           "\n"
    let doc .= '\usepackage{amsmath}'                  . "\n"
    let doc .=                                           "\n"
    let doc .= '\title{}'                              . "\n"
    let doc .= '\author{'                              . "\n"
    let doc .= '    Dimitar Dimitrov\\'                . "\n"
    let doc .= '    \texttt{mitkofr@yahoo.fr}\\'       . "\n"
    let doc .= '}'                                     . "\n"
    let doc .= '\date{\today}'                         . "\n"
    let doc .=                                           "\n"
    let doc .= '\begin{document}'                      . "\n"
    let doc .=                                           "\n"
    let doc .= '\maketitle'                            . "\n"
    let doc .=                                           "\n"
    let doc .= '\end{document}'

    execute 'normal i' . doc . "\<esc>"

endfunction

command! Latex call <sid>Document ()

let &cpoptions = s:savecpo
unlet s:savecpo
