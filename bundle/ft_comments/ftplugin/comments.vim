augroup FT_COMMENTS_GRP

autocmd!

" Comments: \\
autocmd FileType c,cpp,java,javascript
   \ imap <silent> <buffer> <localleader><localleader> /*  */<left><left><left>

" Comments: \cs
autocmd FileType c,cpp,javascript
   \ imap <silent> <buffer> <localleader>cs /*<cr><cr>/<left><up><space>

" Comments: \cs
autocmd FileType java
   \ imap <silent> <buffer> <localleader>cs /**<cr><cr>/<left><up><space>

" autocmd FileType c
" " imap <silent> <buffer> <localleader>p printf("\n");<left><left><left><left><left>

autocmd FileType cpp
   \ imap <silent> <buffer> <localleader>p cout << '' << endl;<left><left><left><left><left><left><left><left><left><left>

" For shell scripts, use bash syntax not sh
autocmd FileType sh
   \ let g:is_bash = 1

" the letter c is used for surrounding
autocmd FileType ruby
   \ imap <silent> <buffer> <localleader>p puts ''<left>|
   \ let b:surround_99 = "=begin \r =end"

" To be improved
autocmd FileType perl
   \ setlocal makeprg=perl\ -c\ %\ $*|
   \ setlocal errorformat=%m\ at\ %f\ line\ %l.

autocmd FileType html,xml
   \ imap <silent> <buffer> <leader><leader> <!--  --><left><left><left><left>|
   \ imap <silent> <buffer> <leader>cs <!--<cr><cr>><left><up><space>|
   \ command! DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc

" [49 1] [50 2] [51 3] [98 b] [101 e] [108 l] [109 m] [77 M] [69 E] [100 d] [112 p]
autocmd FileType tex
   \ let b:surround_49  = "\\section{\r}"                              |
   \ let b:surround_50  = "\\subsection{\r}"                           |
   \ let b:surround_51  = "\\subsubsection{\r}"                        |
   \ let b:surround_98  = "\\textbf{\r}"                               |
   \ let b:surround_101 = "\\emph{\r}"                                 |
   \ let b:surround_108 = "\\\1command: \1{\r}"                        |
   \ let b:surround_109 = "\\begin{math} \r \\end{math}"               |
   \ let b:surround_77  = "\\begin{math}\\displaystyle \r \\end{math}" |
   \ let b:surround_69  = "\\begin{equation} \r \\end{equation}"       |
   \ let b:surround_100 = "\\begin{displaymath} \r \\end{displaymath}" |
   \ let b:surround_112 = "\\left( \r \\right)"                        |
   \ iabbrev latex \latex{}

autocmd Syntax tex
   \ syntax region texFold start=/\\section{.\{-}}/ end=/\\section{.\{-}}/ transparent fold

augroup END
