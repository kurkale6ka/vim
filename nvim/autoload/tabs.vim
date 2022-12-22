function! tabs#gui_tab_label()

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

function! tabs#MyTabLine()

   let s = ''

   for i in range(tabpagenr('$'))

      " select the highlighting
      if i + 1 == tabpagenr()
         let s .= '%#TabLineSel#'
      else
         let s .= '%#TabLine#'
      endif

      " set the tab page number (for mouse clicks)
      let s .= '%' . (i + 1) . 'T'

      " the label is made by MyTabLabel()
      let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

   endfor

   " after the last tab fill with TabLineFill and reset tab page nr
   let s .= '%#TabLineFill#%T'

   " right-align the label to close the current tab page
   if tabpagenr('$') > 1
      let s .= '%=%#TabLine#%999XClose[X]'
   endif

   return s

endfunction

function! MyTabLabel(n)

   let label = ''

   let buflist = tabpagebuflist(a:n)

   " Add '+' if one of the buffers in the tab page is modified
   for bufnr in buflist
      if getbufvar(bufnr, '&modified')
         let label = '+ '
         break
      endif
   endfor

   let winnr = tabpagewinnr(a:n)
   let fname = fnamemodify(bufname(buflist[winnr - 1]), ':t')

   if fname != ''

      let label .= fname
   else
      let label .= '[No Name]'
   endif

   " Append the number of windows in the tab page if more than one
   let wincount = tabpagewinnr(a:n, '$')

   if wincount > 1
      let label .= ' (' . wincount . ')'
   endif

   return label

endfunction
