winpos 0 0
set sessionoptions+=resize

set t_vb=

set guioptions-=m guioptions-=T guioptions+=a

set guifont=DejaVu\ Sans\ Mono\ 13

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

function GuiTabLabel()

    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+ '
            break
        endif
    endfor

    " Append the buffer name
    let fname = fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')

    if fname != ''

        let label .= fname
    else
        let label .= '[No Name]'
    endif

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')

    if wincount > 1
        let label .= ' (' . wincount . ')'
    endif

    return label

endfunction

set guitablabel=%{GuiTabLabel()}
