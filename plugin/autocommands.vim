augroup RC_GRP_FILETYPE
   autocmd!

   " Wrap automatically at 80 chars for plain text files
   autocmd FileType txt,text,svn setlocal formatoptions+=t autoindent smartindent
   autocmd FileType gitcommit execute 'goto|setlocal spell foldmethod&|startinsert'
   autocmd FileType vim setlocal keywordprg=:help
   autocmd FileType json command! -range=% -nargs=* Tidy <line1>,<line2>! python -mjson.tool
   autocmd FileType html,htm,phtml,shtml,xhtml,xml,xsd
      \ imap <silent> <buffer> <localleader><localleader> <!--  --><left><left><left><left>|
      \ imap <silent> <buffer> <localleader>cs <!--<cr><cr>><left><up><space>|
      \ command! -range=% -nargs=* Tidy <line1>,<line2>! xmllint --format --recover - 2>/dev/null|
      \ command! DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc

   " html, server side includes
   autocmd FileType html,htm,phtml,shtml,xhtml
      \ imap <silent> <buffer> <localleader>p <p><cr><cr></p><left><left><left><left><up><tab>|
      \ imap <silent> <buffer> <localleader>d <div><cr><cr></div><left><left><left><left><left><left><up><tab>|
      \ imap <silent> <buffer> <localleader>n <noscript><cr><cr></noscript><left><left><left><left><left><left><left><left><left><left><left><up><tab>|
      \ imap <silent> <buffer> <localleader>s <span></span><left><left><left><left><left><left><left>|
      \ imap <silent> <buffer> <localleader>li <li></li><left><left><left><left><left>|
      \ setlocal include=--\\s*#\\s*include\\s*virtual=\\\|href=|
      \ setlocal includeexpr=substitute(v:fname,'^/','','')

   " Get highlighting for apache version 2.2
   autocmd FileType apache let apache_version = '2.2'
   autocmd FileType vim let vim_indent_cont = &shiftwidth
   autocmd FileType md,markdown
      \ onoremap <buffer> ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>|
      \ onoremap <buffer> ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>

   " Comments: \\
   autocmd FileType java,javascript
      \ imap <silent> <buffer> <localleader><localleader> /*  */<left><left><left>

   " Comments: \cs
   autocmd FileType javascript
      \ imap <silent> <buffer> <localleader>cs /*<cr><cr>/<left><up><space>

   " Comments: \cs
   autocmd FileType java,php
      \ imap <silent> <buffer> <localleader>cs /**<cr><cr>/<left><up><space>

   " Useful for class aware omnicompletion
   autocmd FileType php
      \ let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"|
      \ let php_folding = 3|
      \ let php_large_file = 0|
      \ inoremap <silent> <buffer> <localleader>E <?php echo  ?><left><left><left>

   " autocmd FileType c
   " " imap <silent> <buffer> <localleader>p printf("\n");<left><left><left><left><left>

   " For shell scripts, use bash syntax not sh
   autocmd FileType sh
      \ let g:is_bash = 1

augroup END

augroup RC_GRP_SYNTAX
   autocmd!

   " autocmd Syntax html,htm,phtml,shtml,xhtml
   "    \ syntax clear htmlLink
   "    \ syntax region htmlLink start=/<a\_[[:space:]]\+\_[^>]\{-}\<href\_.\{-}>\_[[:space:]]*/hs=e+1 end="\_[[:space:]]*</a>"he=s-1 contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlPreProc,htmlComment,javaScript,@htmlPreproc

   autocmd Syntax xsd
      \ syntax region xmlComment start=/<\a\+:annotation>/ end=/<\/\a\+:annotation>/

augroup END

augroup RC_GRP_SURROUND
   autocmd!

   " [49 1] [50 2] [51 3] [52 4] [53 5] [54 6] [97 a] [65 A] [101 e] [98 b] [115 s] [83 S] [108 l] [76 L] [100 d] [68 D] [112 p] [80 P] [116 t] [84 T] [104 h] [72 H]
   autocmd FileType html,htm,phtml,shtml,xhtml
      \ let b:surround_49  = "<h1>\r</h1>"                                          |
      \ let b:surround_50  = "<h2>\r</h2>"                                          |
      \ let b:surround_51  = "<h3>\r</h3>"                                          |
      \ let b:surround_52  = "<h4>\r</h4>"                                          |
      \ let b:surround_53  = "<h5>\r</h5>"                                          |
      \ let b:surround_54  = "<h6>\r</h6>"                                          |
      \ let b:surround_97  = "<a href=\"\" title=\"\">\r</a>"                       |
      \ let b:surround_65  = "<a href=\"\" title=\"\" class=\"\1Class: \1\">\r</a>" |
      \ let b:surround_101 = "<em>\r</em>"                                          |
      \ let b:surround_98  = "<strong>\r</strong>"                                  |
      \ let b:surround_115 = "<span>\r</span>"                                      |
      \ let b:surround_83  = "<span class=\"\1Class: \1\">\r</span>"                |
      \ let b:surround_108 = "<li>\r</li>"                                          |
      \ let b:surround_76  = "<li class=\"\1Class: \1\">\r</li>"                    |
      \ let b:surround_100 = "<div>\r</div>"                                        |
      \ let b:surround_68  = "<div class=\"\1Class: \1\">\r</div>"                  |
      \ let b:surround_112 = "<p>\r</p>"                                            |
      \ let b:surround_80  = "<p class=\"\1Class: \1\">\r</p>"                      |
      \ let b:surround_116 = "<td>\r</td>"                                          |
      \ let b:surround_84  = "<td class=\"\1Class: \1\">\r</td>"                    |
      \ let b:surround_104 = "<th>\r</th>"                                          |
      \ let b:surround_72  = "<th class=\"\1Class: \1\">\r</th>"

   " [69 E] [43 +] [45 -] [118 v] [116 t]
   autocmd FileType php
      \ let b:surround_69  = "<?php echo \r ?>"   |
      \ let b:surround_43  = "<?php echo '\r' ?>" |
      \ let b:surround_45  = "<?php \r ?>"        |
      \ let b:surround_118 = "var_dump(\r)"       |
      \ let b:surround_116 = "try { \r } catch (Exception $e) {$e->getMessage();}"

augroup END

augroup RC_GRP_MAKE
   autocmd!

   autocmd FileType php
      \ set makeprg=php\ -l\ %\ $*|
      \ set errorformat=%E%m\ in\ %f\ on\ line\ %l,%Z%m

augroup END

" vim: foldmethod=indent foldnestmax=1
