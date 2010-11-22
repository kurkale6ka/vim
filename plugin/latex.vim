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

    let s:savefo = &formatoptions
    set formatoptions-=r

    let doc  = '% article, proc, minimal, report, book, slides, memoir, letter, beamer'       . "\n"
    let doc .= '\documentclass[12pt,a4paper]{article}'                                        . "\n"
    let doc .=                                                                                  "\n"
    let doc .= '% \usepackage{amsmath}'                                                       . "\n"
    let doc .= '% \usepackage{tocloft}'                                                       . "\n"
    let doc .= '% \renewcommand{\cftsecdotsep}{\cftdotsep}'                                   . "\n"
    let doc .= '% \usepackage[colorlinks=true,urlcolor=blue,linkcolor=cyan]{hyperref}'        . "\n"
    let doc .=                                                                                  "\n"
    let doc .= '\title{}'                                                                     . "\n"
    let doc .= '\author{'                                                                     . "\n"
    let doc .= '    Dimitar Dimitrov\\'                                                       . "\n"
    let doc .= '    \texttt{mitkofr@yahoo.fr}\\'                                              . "\n"
    let doc .= '    % \LaTeXe\footnote%'                                                      . "\n"
    let doc .= '    % {\href{http://www.latex-project.org/}%'                                 . "\n"
    let doc .= '    % {\LaTeX{} -- A document preparation system}}'                           . "\n"
    let doc .= '}'                                                                            . "\n"
    let doc .= '\date{\today}'                                                                . "\n"
    let doc .=                                                                                  "\n"
    let doc .= '\begin{document}'                                                             . "\n"
    let doc .=                                                                                  "\n"
    let doc .= '\maketitle'                                                                   . "\n"
    let doc .= '% \tableofcontents'                                                           . "\n"
    let doc .=                                                                                  "\n"
    let doc .= '% part, chapter, section, subsection, subsubsection, paragraph, subparagraph' . "\n"
    let doc .= '\section{}'                                                                   . "\n"
    let doc .=                                                                                  "\n"
    let doc .= '\end{document}'

    execute 'normal I' . doc . "\<esc>"

    let &formatoptions = s:savefo
    unlet s:savefo

endfunction

function! s:Itemize()

    let list  = '\begin{itemize}' . "\n"
    let list .= '\item{}'         . "\n"
    let list .= '\end{itemize}'

    execute 'normal I' . list . "\<esc>"

endfunction

command! Latex call <sid>Document ()

command! -complete=customlist,<sid>LatexArgs -nargs=+ Latex :call <sid>LatexAction(<f-args>)

function! s:LatexArgs(A,L,P)

    return ['Document', 'Itemize']

endfunction

function! s:LatexAction(action)

    if 'Itemize' == a:action

        call <sid>Itemize()
    else
        call <sid>Document()
    endif

endfunction

let &cpoptions = s:savecpo
unlet s:savecpo
