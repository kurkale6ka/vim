" Html macros and mappings for:
" -----------------------------
"
"    *  Closing      an opening tag
"    *  Wrapping     text with tags
"    *  Increasing   the weight of header tags (<h1>...)
"    *  Formatting   text inside a pair of tags
"    *  Rearranging  <tag> content </tag> vertically
"    *  Stripping    outer tags
"    * 'Spacing'     vertically the content of a pair of tags
"
" Rem: Use zR to unfold everything, then read :help folding
"
" Notes {{{1
"
" Author: Dimitar Dimitrov: mitkofr@yahoo.fr, kurkale6ka
"
" Latest version at:
" http://github.com/kurkale6ka/vimfiles/blob/master/ftplugin/html.vim
"
" Note: Start with :se ft=html for any text where you want to use these
"       macros. The indenting will be done better
"
" Note: Install in:
"             ~/.vim/ftplugin/html.vim
"       ln -s ~/.vim/ftplugin/html.vim phtml.vim
"       ln -s ~/.vim/ftplugin/html.vim   xml.vim
"
" Note: @u, @o, <localleader>hu and <localleader>ho make use of
"       Tabular.vim and myTabularMaps.vim
"       http://github.com/godlygeek/tabular/tree/master
"
"       myTabularMaps.vim must at least contain these two lines:
"
"       AddTabularPipeline! html  /\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>/ tabular#TabularizeStrings(a:lines, '\%(<[^<>?!]*>.\{-}\)\@<!<[^<>?!]*>'  , 'l1')
"       \ | tabular#TabularizeStrings(a:lines, '<\/[A-Za-z:]\+>\%(.\{-}<\/[A-Za-z:]\+>\)\@!', 'l1')
"
" Note: <localleader>hg, <localleader>hr, <localleader>hx and <localleader>hm don't work on nested
"       <!-- --> and <?php  ?>
"       and can't be used while positioned on the first char in the file
"
" Note: If you must use @u, @o, @p, @d or <localleader>hu, <localleader>ho till the eof,
"       be 'careful' to add an empty line at the eof
"
" Note: 7@p won't work if one of the paragraphs starts with a one letter word
"       (ex: I). Same for <> 7 or another macro or on words.
" }}}1

" 1. Close an opening tag {{{1
" ----------------------------
"
"     >> : <tag> newline </tag> (write quickly a second > after the first one)
"     >/ : <tag>         </tag>
"     <? : <?php             ?>
"
" 2. Wrapping: {{{1
" -----------------
"
"         +-----------+-------------------+
"         | paragraph | WORD or selection |
" +-------+-----------+-------------------+
" | <ul>  |    @u     |    <localleader>hu     |
" | <ol>  |    @o     |    <localleader>ho     |
" | <p>   |    @p     |    <localleader>hp     |
" | <div> |    @d     |    <localleader>hd     |
" +-------+-----------+-------------------+
"
" Note: <localleader>hu and <localleader>ho work on fully selected lines only
"
" Note: mnemo for paragraphs and lines: wrap @ll
"
" Note: You can use a count with the \ mappings
"
"              +------+-------------------+
"              | line | WORD or selection |
" +------------+------+-------------------+
" | <td>       |  @t  |    <localleader>ht     |
" | <a>        |  @a  |    <localleader>ha     |
" | <span>     |  @s  |    <localleader>hs     |
" | <h1>       |  @h  |    <localleader>hh     |
" | <li>       |  @l  |    <localleader>hl     |
" | <!-- -->   |  @c  |    <localleader>hc     |
" | <em>       |  @e  |    <localleader>he     |
" | <strong>   |  @b  |    <localleader>hb     |
"
"   TODO:
"
" | <fieldset> |  @f  |    <localleader>hf     |
" | <kbd>      |  @k  |    <localleader>hk     |
" | <noscript> |  @n  |    <localleader>hn     |
" | <var>      |  @v  |    <localleader>hv     |
" +------------+------+-------------------+
"
" 3. Insert an image {{{1
" -----------------------
"
"     @i (<img src='X' alt='' title='' />)
"
" 4. Set the class of a tag {{{1
" ------------------------------
"
"     :Class ul         -> <ul> (default)
"     :Class ul bg_blue -> <ul class='bg_blue'>
"
" Note: Try using :C or :Cl or... instead of :Class. Depending on the
"       installed plugins, a shorter or longer abbreviation might work.
"
" Shortcuts: (:C shortcut)
"     d,   s,    u,  o,  h,  l,  t,  i,   e,  b
"     div, span, ul, ol, h1, li, td, img, em, strong
"
" Note: If you don't want to write a tag manually, you can use <tab>
"       after :Class to autocomplete your tag.
"       (put a space after :Class before hitting <tab>)
"
" 5. <hn -> <hn+1 (Use after a @h or <localleader>hh) {{{1
" ---------------------------------------------------
"
"     @j (mnemo: j is just besides h on the keyboard)
"
" 6. gq inside a pair of tags {{{1
" --------------------------------
"
"     @g for standard tags
"     <localleader>hg for <!-- --> or <?php ?>
"
" 7. Rearrange <tag> content </tag> vertically {{{1
" -------------------------------------------------
"
"     @r for standard tags
"     <localleader>hr for <!-- --> or <?php ?>
"
" 8. Strip outer tags {{{1
" ------------------------
"
"     @x for standard tags
"     <localleader>hx for <!-- --> or <?php ?>
"
" 9. 'Space' vertically the content of a pair of tags {{{1
" --------------------------------------------------------
"
"     @m for standard tags (mnemo: )
"     <localleader>hm for <!-- --> or <?php ?>
" }}}1

if exists('g:loaded_html') || &compatible || v:version < 700

   if &compatible && &verbose

      echo "Html.vim is not designed to work in compatible mode."

   elseif v:version < 700

      echo "Html.vim needs Vim 7.0 or above to work correctly."
   endif

   finish
endif

let g:loaded_html = 1

let s:savecpo = &cpoptions
set cpoptions&vim

" Code {{{1

" Tag classes = '' {{{2
" ---------------------

" <ul>
if !exists("b:ul_class")
   let b:ul_class = ''
endif

" <ol>
if !exists("b:ol_class")
   let b:ol_class = ''
endif

" <p>
if !exists("b:p_class")
   let b:p_class = ''
endif

" <div>
if !exists("b:div_class")
   let b:div_class = ''
endif

" <td>
if !exists("b:td_class")
   let b:td_class = ''
endif

" <a>
if !exists("b:a_class")
   let b:a_class = ''
endif

" <span>
if !exists("b:span_class")
   let b:span_class = ''
endif

" <h1>
if !exists("b:h1_class")
   let b:h1_class = ''
endif

" <img>
if !exists("b:i_class")
   let b:i_class = ''
endif

" <em>
if !exists("b:em_class")
   let b:em_class = ''
endif

" <strong>
if !exists("b:b_class")
   let b:b_class = ''
endif

" <li>
if !exists("b:li_class")
   let b:li_class = ''
endif

" Init functions: set the class to the right value {{{2
" -----------------------------------------------------
"
"  first  line: macro   for wrapping a paragraph or a line
"  second line: mapping for wrapping a WORD
"  third  line: mapping for wrapping a selection

function! s:Init_ul()

   let @u="dipO<ul" . b:ul_class . ">\<cr>\<cr>\<cr></ul>\<esc>kP0\<c-v>']I<li>\<esc>gv$A</li>\<esc>gv:Tabularize html\<cr>-=at']+EB"
   nnoremap <silent> <buffer> <localleader>#u ciW<ul<esc>:exe 'norm a' . b:ul_class . "> <li>   </li> </ul>\eB2hvitholp3EB"<cr>
   vnoremap <silent> <buffer> <localleader>hu <c-v>^I<li><esc>gv$A</li><esc>gv:Tabularize html<cr>d']O<ul<esc>:exe 'norm a' . b:ul_class . ">\r\r\r</ul>\ekP-=at']+EB"<cr>

endfunction

function! s:Init_ol()

   let @o="dipO<ol" . b:ol_class . ">\<cr>\<cr>\<cr></ol>\<esc>kP0\<c-v>']I<li>\<esc>gv$A</li>\<esc>gv:Tabularize html\<cr>-=at']+EB"
   nnoremap <silent> <buffer> <localleader>#o ciW<ol<esc>:exe 'norm a' . b:ol_class . "> <li>   </li> </ol>\eB2hvitholp3EB"<cr>
   vnoremap <silent> <buffer> <localleader>ho <c-v>^I<li><esc>gv$A</li><esc>gv:Tabularize html<cr>d']O<ol<esc>:exe 'norm a' . b:ol_class . ">\r\r\r</ol>\ekP-=at']+EB"<cr>

endfunction

function! s:Init_p()

   let @p="dipO<p" . b:p_class . ">\<cr>\<cr>\<c-r>\"\<cr></p>\<esc>=at']+EB"
   nnoremap <silent> <buffer> <localleader>#p ciW<p<esc>:exe 'norm a' . b:p_class . ">   </p>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>hp c<p<esc>:exe 'norm a' . b:p_class . ">   </p>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_div()

   let @d="dipO<div" . b:div_class . ">\<cr>\<cr>\<c-r>\"\<cr></div>\<esc>=at']+EB"
   nnoremap <silent> <buffer> <localleader>#d ciW<div<esc>:exe 'norm a' . b:div_class . ">   </div>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>hd c<div<esc>:exe 'norm a' . b:div_class . ">   </div>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_td()

   let @t="I<td" . b:td_class . "> \<end> </td>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#t ciW<td<esc>:exe 'norm a' . b:td_class . ">   </td>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>ht c<td<esc>:exe 'norm a' . b:td_class . ">   </td>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_a()

   let @a="^y$i<a href='\<esc>pa'" . b:a_class . "> \<end> </a>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#a ciW<a href=''<esc>gP:exe 'norm a' . b:a_class . ">   </a>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>ha c<a href=''<esc>gP:exe 'norm a' . b:a_class . ">   </a>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_span()

   let @s="I<span" . b:span_class . "> \<end> </span>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#s ciW<span<esc>:exe 'norm a' . b:span_class . ">   </span>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>hs c<span<esc>:exe 'norm a' . b:span_class . ">   </span>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_h1()

   let @h="I<h1" . b:h1_class . "> \<end> </h1>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#h ciW<h1<esc>:exe 'norm a' . b:h1_class . ">   </h1>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>hh c<h1<esc>:exe 'norm a' . b:h1_class . ">   </h1>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_i()

   let @i="i<img src='' alt='' title=''" . b:i_class . " />\<esc>`[2Ei"

endfunction

function! s:Init_em()

   let @e="I<em" . b:em_class . "> \<end> </em>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#e ciW<em<esc>:exe 'norm a' . b:em_class . ">   </em>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>he c<em<esc>:exe 'norm a' . b:em_class . ">   </em>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_b()

   let @b="I<strong" . b:b_class . "> \<end> </strong>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#b ciW<strong<esc>:exe 'norm a' . b:b_class . ">   </strong>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>hb c<strong<esc>:exe 'norm a' . b:b_class . ">   </strong>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

function! s:Init_li()

   let @l="I<li" . b:li_class . "> \<end> </li>\<esc>+EB"
   nnoremap <silent> <buffer> <localleader>#l ciW<li<esc>:exe 'norm a' . b:li_class . ">   </li>\evitholp2EB"<cr>
   vnoremap <silent> <buffer> <localleader>hl c<li<esc>:exe 'norm a' . b:li_class . ">   </li>\evitholgpvatov:s/\\s\\+$//ge\r=atvatv"<cr>

endfunction

call s:Init_ul  ()
call s:Init_ol  ()
call s:Init_p   ()
call s:Init_div ()
call s:Init_td  ()
call s:Init_a   ()
call s:Init_span()
call s:Init_h1  ()
call s:Init_i   ()
call s:Init_em  ()
call s:Init_b   ()
call s:Init_li  ()

" Set the class of a tag {{{2
" ---------------------------

function! s:SetClass(tag, ...)

   if 'ul' == a:tag || 'u' == a:tag

      if !exists("a:1")
         let b:ul_class = ''
      else
         let b:ul_class = " class='" . a:1 . "'"
      endif

      call s:Init_ul()

   elseif 'ol' == a:tag || 'o' == a:tag

      if !exists("a:1")
         let b:ol_class = ''
      else
         let b:ol_class = " class='" . a:1 . "'"
      endif

      call s:Init_ol()

   elseif 'p' == a:tag

      if !exists("a:1")
         let b:p_class = ''
      else
         let b:p_class = " class='" . a:1 . "'"
      endif

      call s:Init_p()

   elseif 'div' == a:tag || 'd' == a:tag

      if !exists("a:1")
         let b:div_class = ''
      else
         let b:div_class = " class='" . a:1 . "'"
      endif

      call s:Init_div()

   elseif 'td' == a:tag || 't' == a:tag

      if !exists("a:1")
         let b:td_class = ''
      else
         let b:td_class = " class='" . a:1 . "'"
      endif

      call s:Init_td()

   elseif 'a' == a:tag

      if !exists("a:1")
         let b:a_class = ''
      else
         let b:a_class = " class='" . a:1 . "'"
      endif

      call s:Init_a()

   elseif 'span' == a:tag || 's' == a:tag

      if !exists("a:1")
         let b:span_class = ''
      else
         let b:span_class = " class='" . a:1 . "'"
      endif

      call s:Init_span()

   elseif 'h1' == a:tag || 'h' == a:tag

      if !exists("a:1")
         let b:h1_class = ''
      else
         let b:h1_class = " class='" . a:1 . "'"
      endif

      call s:Init_h1()

   elseif 'img' == a:tag || 'i' == a:tag

      if !exists("a:1")
         let b:i_class = ''
      else
         let b:i_class = " class='" . a:1 . "'"
      endif

      call s:Init_i()

   elseif 'em' == a:tag || 'e' == a:tag

      if !exists("a:1")
         let b:em_class = ''
      else
         let b:em_class = " class='" . a:1 . "'"
      endif

      call s:Init_em()

   elseif 'strong' == a:tag || 'b' == a:tag

      if !exists("a:1")
         let b:b_class = ''
      else
         let b:b_class = " class='" . a:1 . "'"
      endif

      call s:Init_b()

   elseif 'li' == a:tag || 'l' == a:tag

      if !exists("a:1")
         let b:li_class = ''
      else
         let b:li_class = " class='" . a:1 . "'"
      endif

      call s:Init_li()

   endif

endfunction

command! -buffer -complete=customlist,<sid>HtmlTags -nargs=+ Class :call <sid>SetClass(<f-args>)

function! s:HtmlTags(A,L,P)

   return ['div ', 'span ', 'ul ', 'ol ', 'h1 ', 'li ', 'td ', 'img ', 'em ', 'strong ', 'a ', 'p ']

endfunction

" Close an opening tag {{{2
" -------------------------

"" Each tag on a new line
"
"inoremap <silent> <buffer> >> > </><esc>4hvi<ov"*yiw`>4l"*p`[3hr<cr>O
"
"" Both tags on the same line
"
"inoremap <silent> <buffer> >/ ></><esc>3hvi<ov"*yiw`>3l"*pcit  <left>
"
"inoremap <silent> <buffer> <? <?php  ?><left><left><left>

" Wrap a line, a WORD or a selection with <!-- --> {{{2
" -----------------------------------------------------

let @c="I<!-- \<end> -->\<esc>+EB"
nnoremap <silent> <buffer> <localleader>#c ciW<!-- <c-r>- --><esc>EB
vnoremap <silent> <buffer> <localleader>hc c<!--   --><esc>B2hvgpv?<!--<cr>:s/\s\+$//ge<cr>gv=`>:call search('->', 'e')<cr>

" Allow count for wrapping a single WORD or a selection {{{2
" ----------------------------------------------------------

nnoremap <silent> <buffer> <localleader>hu @='\#u'<cr>
nnoremap <silent> <buffer> <localleader>ho @='\#o'<cr>
nnoremap <silent> <buffer> <localleader>hp @='\#p'<cr>
nnoremap <silent> <buffer> <localleader>hd @='\#d'<cr>
nnoremap <silent> <buffer> <localleader>ht @='\#t'<cr>
nnoremap <silent> <buffer> <localleader>ha @='\#a'<cr>
nnoremap <silent> <buffer> <localleader>hs @='\#s'<cr>
nnoremap <silent> <buffer> <localleader>hh @='\#h'<cr>
nnoremap <silent> <buffer> <localleader>he @='\#e'<cr>
nnoremap <silent> <buffer> <localleader>hb @='\#b'<cr>
nnoremap <silent> <buffer> <localleader>hl @='\#l'<cr>
nnoremap <silent> <buffer> <localleader>hc @='\#c'<cr>

" <hn -> <hn+1 {{{2
" -----------------

let @j="vatov\<c-a>gvovB."

" gq inside a pair of tags {{{2
" -----------------------------

let @g="=atvitgeowgq+e+EB"

nnoremap <silent> <buffer> <localleader>#g ?\_.\=<!--\<bar>\_.\=<\?php<cr>/-->\<bar>?><cr>v?<!--\<bar><\?php<cr>=gvwo-gq`>2+EB:noh<cr>

nnoremap <silent> <buffer> <localleader>hg @='\#g'<cr>

" Rearrange <tag> content </tag> vertically {{{2
" ----------------------------------------------

let @r="cit\<cr>\<esc>:pu!\<cr>:s/\\s\\+$//ge\<cr>+=atjgqqjo\<esc>EB"

nnoremap <silent> <buffer> <localleader>#r ?\_.\=<!--\<bar>\_.\=<\?php<cr>/-->\<bar>?>/s-1<cr>v?<!--\<bar><\?php?e+1<cr>c<cr><esc>:pu!<cr>:s/\s\+$//ge<cr>?<!--\<bar><\?php<cr>v/-->\<bar>?><cr>=jgqqjo<esc>EB:noh<cr>

nnoremap <silent> <buffer> <localleader>hr @='\#r'<cr>

" Strip outer tags {{{2
" ---------------------

let @x="vitdvatpgv:s/\\s\\+$//ge\<cr>gv=`>EB"

nnoremap <silent> <buffer> <localleader>#x ?\_.\=<!--\<bar>\_.\=<\?php<cr>/-->\<bar>?>/s-1<cr>v?<!--\<bar><\?php?e+1<cr>d?<!--\<bar><\?php<cr>v/-->\<bar>?>/e<cr>pgv=`>EB:noh<cr>

nnoremap <silent> <buffer> <localleader>hx @='\#x'<cr>

" 'Space' content of a pair of tags {{{2
" --------------------------------------

let @m="vitgeowVc\<cr>\<esc>P-=at']+EB"

nnoremap <silent> <buffer> <localleader>#m ?\_.\=<!--\<bar>\_.\=<\?php<cr>/-->\<bar>?><cr>O<esc>+v?<!--\<bar><\?php<cr>=o<esc>`>+EB:noh<cr>

nnoremap <silent> <buffer> <localleader>hm @='\#m'<cr>

let &cpoptions = s:savecpo
unlet s:savecpo

" vim: set foldmethod=marker foldmarker&:
