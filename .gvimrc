" vim selections available in "+ for outside apps
set guioptions+=P

set t_vb= " no visual bell notifications

"" Position and size
winpos 0 0

set sessionoptions+=resize

"" Appearance
" Tab labels
set guitablabel=%{tabs#gui_tab_label()}

set guioptions-=m " no menu
set guioptions-=T " no toolbar

"" Mouse
set mousemodel=extend

" I like my cursor pointing left when selecting text
set mouseshape=i-r:beam,s:updown,sd:udsizing,vs:leftright,vd:lrsizing,m:no,
   \ml:up-arrow,
   \v:arrow

"" Font size
set guifont=DejaVu\ Sans\ Mono\ 12

command! -count=1 -bar Bigger  :let &gfn = substitute(&gfn,'\d\+$','\=submatch(0)+<count>','')
command! -count=1 -bar Smaller :let &gfn = substitute(&gfn,'\d\+$','\=submatch(0)-<count>','')

"" Saving buffers
" current
nmap <c-s>s      :update<cr>
imap <c-s>s <c-o>:update<cr>

nmap <c-s><c-s>      :update<cr>
imap <c-s><c-s> <c-o>:update<cr>

" all
nmap <c-s>a      :wall<cr>
imap <c-s>a <c-o>:wall<cr>

nmap <c-s><c-a>      :wall<cr>
imap <c-s><c-a> <c-o>:wall<cr>

"" Ctrl + Enter to open a line below in INSERT mode
imap <c-cr> <esc>o
imap <s-cr> <esc>O

" vim: fdm=expr fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"""*')-1)\:'='
