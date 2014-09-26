winpos 0 0
set sessionoptions+=resize

set t_vb=

set guioptions-=m guioptions-=T guioptions+=P

set guifont=DejaVu\ Sans\ Mono\ 13

command! -count=1 -bar Bigger  :let &gfn = substitute(&gfn,'\d\+$','\=submatch(0)+<count>','')
command! -count=1 -bar Smaller :let &gfn = substitute(&gfn,'\d\+$','\=submatch(0)-<count>','')

" Save this/all file(s)
nmap <c-s>s          :update<cr>
imap <c-s>s     <c-o>:update<cr>
nmap <c-s><c-s>      :update<cr>
imap <c-s><c-s> <c-o>:update<cr>
nmap <c-s><c-a>      :wall<cr>
imap <c-s><c-a> <c-o>:wall<cr>
nmap <c-s>a          :wall<cr>
imap <c-s>a     <c-o>:wall<cr>

set mousemodel=extend

" I like my cursor pointing left when selecting text
set mouseshape=i-r:beam,s:updown,sd:udsizing,vs:leftright,vd:lrsizing,m:no,
   \ml:up-arrow,
   \v:arrow

set guitablabel=%{tabs#gui_tab_label()}
