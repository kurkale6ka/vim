" Comments: \\ and \cs
imap <silent> <buffer> <localleader><localleader> <!--  --><left><left><left><left>
imap <silent> <buffer> <localleader>cs            <!--<cr><cr>><left><up><space>

command! -buffer -range=% -nargs=* Tidy <line1>,<line2>! xmllint --format --recover - 2>/dev/null
command! -buffer DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc

imap <silent> <buffer> <localleader>p  <p><cr><cr></p><left><left><left><left><up><tab>
imap <silent> <buffer> <localleader>d  <div><cr><cr></div><left><left><left><left><left><left><up><tab>
imap <silent> <buffer> <localleader>n  <noscript><cr><cr></noscript><left><left><left><left><left><left><left><left><left><left><left><up><tab>
imap <silent> <buffer> <localleader>s  <span></span><left><left><left><left><left><left><left>
imap <silent> <buffer> <localleader>li <li></li><left><left><left><left><left>

" Server side includes
setlocal include=--\\s*#\\s*include\\s*virtual=\\\|href=
setlocal includeexpr=substitute(v:fname,'^/','','')

" [49 1] [50 2] [51 3] [52 4] [53 5] [54 6] [97 a] [65 A] [101 e] [98 b] [115 s] [83 S] [108 l] [76 L] [100 d] [68 D] [112 p] [80 P] [116 t] [84 T] [104 h] [72 H]
let b:surround_49  = "<h1>\r</h1>"
let b:surround_50  = "<h2>\r</h2>"
let b:surround_51  = "<h3>\r</h3>"
let b:surround_52  = "<h4>\r</h4>"
let b:surround_53  = "<h5>\r</h5>"
let b:surround_54  = "<h6>\r</h6>"
let b:surround_97  = "<a href=\"\" title=\"\">\r</a>"
let b:surround_65  = "<a href=\"\" title=\"\" class=\"\1Class: \1\">\r</a>"
let b:surround_101 = "<em>\r</em>"
let b:surround_98  = "<strong>\r</strong>"
let b:surround_115 = "<span>\r</span>"
let b:surround_83  = "<span class=\"\1Class: \1\">\r</span>"
let b:surround_108 = "<li>\r</li>"
let b:surround_76  = "<li class=\"\1Class: \1\">\r</li>"
let b:surround_100 = "<div>\r</div>"
let b:surround_68  = "<div class=\"\1Class: \1\">\r</div>"
let b:surround_112 = "<p>\r</p>"
let b:surround_80  = "<p class=\"\1Class: \1\">\r</p>"
let b:surround_116 = "<td>\r</td>"
let b:surround_84  = "<td class=\"\1Class: \1\">\r</td>"
let b:surround_104 = "<th>\r</th>"
let b:surround_72  = "<th class=\"\1Class: \1\">\r</th>"
