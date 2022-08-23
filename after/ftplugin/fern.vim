nmap <buffer><expr>
      \ <Plug>(fern-my-open-expand-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open:select)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )

nmap <buffer>          <CR> <Plug>(fern-my-open-expand-collapse)
nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)

nmap <buffer> - <Plug>(fern-action-leave)
