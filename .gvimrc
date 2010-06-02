winpos 0 0
set sessionoptions+=resize

set t_vb=

set guioptions-=m
set guioptions-=T
set guioptions+=a

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
    let label .= fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(v:lnum, '$')

    if wincount > 1
        let label .= ' (' . wincount . ')'
    endif

    return label

endfunction

set guitablabel=%{GuiTabLabel()}
