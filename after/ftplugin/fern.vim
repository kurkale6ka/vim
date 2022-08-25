nmap <buffer><expr>
      \ <Plug>(fern-my-open-expand-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open:select)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

nmap <buffer>          <CR> <Plug>(fern-my-open-expand-collapse)
nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)

map <buffer> * <Plug>(fern-action-mark:toggle)

nmap <buffer><nowait> - <Plug>(fern-action-leave)
nmap <buffer><nowait> < <Plug>(fern-action-leave)
nmap <buffer><nowait> > <Plug>(fern-action-enter)

setlocal nonumber
setlocal signcolumn=no

call glyph_palette#apply()
